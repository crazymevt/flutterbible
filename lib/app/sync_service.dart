import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

import '../data/user_store.dart';

import '../data/sync/file_sync_engine.dart';
import '../domain/sync/lww_merge.dart';
import 'user_providers.dart';

final deviceIdProvider = FutureProvider<String>((ref) async {
  final docs = await getApplicationDocumentsDirectory();
  final file = File(p.join(docs.path, 'device_id.txt'));
  if (await file.exists()) {
    return await file.readAsString();
  } else {
    final newId = const Uuid().v4();
    await file.writeAsString(newId);
    return newId;
  }
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final userStore = ref.watch(userStoreProvider);
  return SyncService(userStore, ref);
});

class SyncService {
  final UserStore _store;
  final Ref _ref;
  FileSyncEngine? _engine;

  SyncService(this._store, this._ref);

  Future<void> _ensureInit() async {
    if (_engine != null) return;

    final deviceId = await _ref.read(deviceIdProvider.future);

    // We place the sync folder inside Documents/StudyBibleSync for easy user access.
    // In production, the user would select an external sync folder (like a Syncthing folder).
    final docs = await getApplicationDocumentsDirectory();
    final syncDir = Directory(p.join(docs.path, 'StudyBibleSync'));

    _engine = FileSyncEngine(syncFolder: syncDir, localDeviceId: deviceId);
  }

  Future<void> sync() async {
    await _ensureInit();

    // 1. Get all local records
    final localHighlights = await _store.select(_store.highlights).get();
    final localNotes = await _store.select(_store.notes).get();
    final localBookmarks = await _store.select(_store.bookmarks).get();

    final localRecords = <GenericSyncRecord>[];

    localRecords.addAll(
      localHighlights.map(
        (h) => GenericSyncRecord(
          id: h.id,
          updatedAt: h.updatedAt,
          deviceId: h.deviceId,
          deleted: h.deleted,
          payload: {
            'type': 'highlight',
            'bookName': h.bookName,
            'chapter': h.chapter,
            'verse': h.verse,
            'colorHex': h.colorHex,
          },
        ),
      ),
    );

    localRecords.addAll(
      localNotes.map(
        (n) => GenericSyncRecord(
          id: n.id,
          updatedAt: n.updatedAt,
          deviceId: n.deviceId,
          deleted: n.deleted,
          payload: {
            'type': 'note',
            'bookName': n.bookName,
            'chapter': n.chapter,
            'verse': n.verse,
            'content': n.content,
          },
        ),
      ),
    );

    localRecords.addAll(
      localBookmarks.map(
        (b) => GenericSyncRecord(
          id: b.id,
          updatedAt: b.updatedAt,
          deviceId: b.deviceId,
          deleted: b.deleted,
          payload: {
            'type': 'bookmark',
            'bookName': b.bookName,
            'chapter': b.chapter,
            'verse': b.verse,
            'label': b.label,
          },
        ),
      ),
    );

    // 2. Pull remote records
    final remoteRecordsRaw = await _engine!.pull();
    final remoteRecords = remoteRecordsRaw.cast<GenericSyncRecord>();

    // 3. Merge
    final merged = mergeRecords(localRecords, remoteRecords);

    // 4. Update local DB
    await _store.transaction(() async {
      for (final rec in merged) {
        final type = rec.payload['type'] as String?;
        if (type == 'highlight') {
          final highlight = Highlight(
            id: rec.id,
            updatedAt: rec.updatedAt,
            deviceId: rec.deviceId,
            deleted: rec.deleted,
            bookName: rec.payload['bookName'] as String,
            chapter: rec.payload['chapter'] as int,
            verse: rec.payload['verse'] as int,
            colorHex: rec.payload['colorHex'] as String,
          );
          await _store
              .into(_store.highlights)
              .insert(highlight, mode: InsertMode.replace);
        } else if (type == 'note') {
          final note = Note(
            id: rec.id,
            updatedAt: rec.updatedAt,
            deviceId: rec.deviceId,
            deleted: rec.deleted,
            bookName: rec.payload['bookName'] as String,
            chapter: rec.payload['chapter'] as int,
            verse: rec.payload['verse'] as int?,
            content: rec.payload['content'] as String,
          );
          await _store
              .into(_store.notes)
              .insert(note, mode: InsertMode.replace);
        } else if (type == 'bookmark') {
          final bookmark = Bookmark(
            id: rec.id,
            updatedAt: rec.updatedAt,
            deviceId: rec.deviceId,
            deleted: rec.deleted,
            bookName: rec.payload['bookName'] as String,
            chapter: rec.payload['chapter'] as int,
            verse: rec.payload['verse'] as int,
            label: rec.payload['label'] as String,
          );
          await _store
              .into(_store.bookmarks)
              .insert(bookmark, mode: InsertMode.replace);
        }
      }
    });

    // 5. Push the resulting state
    await _engine!.push(merged);
  }
}
