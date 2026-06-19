import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/content_tables.dart';

part 'content_store.g.dart';

@DriftDatabase(tables: [
  Versions,
  Books,
  Verses,
  CrossReferences,
  Commentaries,
  CommentaryEntries,
  Dictionaries,
  DictionaryEntries,
])
class ContentStore extends _$ContentStore {
  ContentStore([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await customStatement('''
          CREATE VIRTUAL TABLE IF NOT EXISTS content_search USING fts5(type UNINDEXED, reference_id UNINDEXED, text_content);
        ''');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Future upgrades
        }
      },
    );
  }

  Future<void> deleteVersion(String versionId) async {
    await transaction(() async {
      await customStatement("DELETE FROM content_search WHERE type='verse' AND reference_id IN (SELECT v.id FROM verses v JOIN books b ON v.book_id = b.id WHERE b.version_id = ?)", [versionId]);
      
      final bookIds = await (select(books)..where((b) => b.versionId.equals(versionId))).map((b) => b.id).get();
      if (bookIds.isNotEmpty) {
        await (delete(verses)..where((v) => v.bookId.isIn(bookIds))).go();
        await (delete(books)..where((b) => b.id.isIn(bookIds))).go();
      }
      await (delete(versions)..where((v) => v.id.equals(versionId))).go();
    });
  }

  Future<void> deleteCommentary(int id) async {
    await transaction(() async {
      await customStatement("DELETE FROM content_search WHERE type='commentary' AND reference_id IN (SELECT id FROM commentary_entries WHERE commentary_id = ?)", [id]);
      await (delete(commentaryEntries)..where((c) => c.commentaryId.equals(id))).go();
      await (delete(commentaries)..where((c) => c.id.equals(id))).go();
    });
  }

  Future<void> deleteDictionary(int id) async {
    await transaction(() async {
      await customStatement("DELETE FROM content_search WHERE type='dictionary' AND reference_id IN (SELECT id FROM dictionary_entries WHERE dictionary_id = ?)", [id]);
      await (delete(dictionaryEntries)..where((d) => d.dictionaryId.equals(id))).go();
      await (delete(dictionaries)..where((d) => d.id.equals(id))).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'content.db'));
    
    return NativeDatabase.createInBackground(file);
  });
}
