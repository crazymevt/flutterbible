import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/sync/file_sync_engine.dart';
import 'package:study_bible/data/sync/sync_storage.dart';

void main() {
  late Directory tmpDir;
  late IoSyncStorage storage;

  setUp(() async {
    tmpDir = await Directory.systemTemp.createTemp('sync_engine_test');
    storage = IoSyncStorage(tmpDir);
  });

  tearDown(() async {
    await tmpDir.delete(recursive: true);
  });

  GenericSyncRecord record(String id, {String device = 'A', int at = 1}) =>
      GenericSyncRecord(
        id: id,
        updatedAt: at,
        deviceId: device,
        deleted: false,
        payload: {'value': 'v$id'},
      );

  test('push writes this device state file and creates the folder', () async {
    final dir = Directory('${tmpDir.path}/nested');
    final engine =
        FileSyncEngine(storage: IoSyncStorage(dir), localDeviceId: 'A');

    await engine.push([record('1'), record('2')]);

    final file = File('${dir.path}/state-A.jsonl');
    expect(await file.exists(), isTrue);
    expect((await file.readAsLines()).where((l) => l.isNotEmpty), hasLength(2));
  });

  test('pull reads other devices but skips this device own file', () async {
    await FileSyncEngine(storage: storage, localDeviceId: 'A')
        .push([record('local', device: 'A')]);
    await FileSyncEngine(storage: storage, localDeviceId: 'B')
        .push([record('remote', device: 'B')]);

    final pulled = await FileSyncEngine(storage: storage, localDeviceId: 'A')
        .pull();

    expect(pulled.map((r) => r.id), ['remote']);
  });

  test('pull returns empty for a folder that does not exist yet', () async {
    final engine = FileSyncEngine(
      storage: IoSyncStorage(Directory('${tmpDir.path}/absent')),
      localDeviceId: 'A',
    );
    expect(await engine.pull(), isEmpty);
  });

  test('pull ignores malformed json lines', () async {
    await File('${tmpDir.path}/state-B.jsonl')
        .writeAsString('not json\n{"id":"ok","updatedAt":1,"deviceId":"B","deleted":false}\n');

    final pulled =
        await FileSyncEngine(storage: storage, localDeviceId: 'A').pull();

    expect(pulled.map((r) => r.id), ['ok']);
  });

  test('push overwrites the previous state rather than appending', () async {
    final engine = FileSyncEngine(storage: storage, localDeviceId: 'A');
    await engine.push([record('1'), record('2')]);
    await engine.push([record('3')]);

    final lines = (await File('${tmpDir.path}/state-A.jsonl').readAsLines())
        .where((l) => l.isNotEmpty);
    expect(lines, hasLength(1));
  });
}
