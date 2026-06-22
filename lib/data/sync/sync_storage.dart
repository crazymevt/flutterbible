import 'dart:io';
import 'package:path/path.dart' as p;

/// The minimal document-store surface the sync engine needs, decoupled from any
/// particular backend.
///
/// The default and desktop/macOS paths use [IoSyncStorage] (a plain `dart:io`
/// directory). Android uses a Storage Access Framework implementation so users
/// can point sync at any folder without the `MANAGE_EXTERNAL_STORAGE`
/// permission, which Google Play does not allow for an app like this.
abstract class SyncStorage {
  /// A stable identifier for the underlying location, used by the sync service
  /// to detect when the configured target has changed.
  String get id;

  /// Create or overwrite the document named [name] with [contents].
  Future<void> writeDocument(String name, String contents);

  /// Names of all documents whose name ends with [suffix].
  Future<List<String>> listDocuments(String suffix);

  /// The lines of the document named [name], or an empty list if it is absent.
  Future<List<String>> readLines(String name);
}

/// A [SyncStorage] backed by a real filesystem [Directory].
class IoSyncStorage implements SyncStorage {
  final Directory directory;

  IoSyncStorage(this.directory);

  @override
  String get id => directory.path;

  @override
  Future<void> writeDocument(String name, String contents) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    await File(p.join(directory.path, name)).writeAsString(contents);
  }

  @override
  Future<List<String>> listDocuments(String suffix) async {
    if (!await directory.exists()) return [];
    return directory
        .listSync()
        .whereType<File>()
        .map((f) => p.basename(f.path))
        .where((name) => name.endsWith(suffix))
        .toList();
  }

  @override
  Future<List<String>> readLines(String name) async {
    final file = File(p.join(directory.path, name));
    if (!await file.exists()) return [];
    return file.readAsLines();
  }
}
