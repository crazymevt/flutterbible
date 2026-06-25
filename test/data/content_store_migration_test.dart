import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:study_bible/data/content_store.dart';

void main() {
  test('onCreate recovers from an interrupted create (tables present, version 0)',
      () async {
    final dir = await Directory.systemTemp.createTemp('content_store_migration');
    final file = File('${dir.path}/content.db');
    try {
      // First open runs the full onCreate and stamps the schema version.
      final store1 = ContentStore(NativeDatabase(file));
      await store1.customSelect('SELECT 1').get(); // force the lazy open
      await store1.close();

      // Simulate an interrupted onCreate: the tables are committed on disk, but
      // drift never got to stamp the schema version. It reads back as 0, so the
      // next open treats the database as fresh and runs onCreate again.
      final raw = sqlite.sqlite3.open(file.path);
      raw.execute('PRAGMA user_version = 0');
      raw.close();

      // The re-run must be idempotent — a plain createAll() would throw
      // "table already exists" here and wedge every future open.
      final store2 = ContentStore(NativeDatabase(file));
      final row = await store2
          .customSelect('SELECT count(*) AS c FROM versions')
          .getSingle();
      expect(row.read<int>('c'), 0);
      await store2.close();
    } finally {
      await dir.delete(recursive: true);
    }
  });
}
