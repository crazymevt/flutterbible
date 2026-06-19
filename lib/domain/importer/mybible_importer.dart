import 'dart:io';
import 'dart:convert';
import 'package:sqlite3/sqlite3.dart';
import 'package:drift/drift.dart';
import '../../data/content_store.dart';
import '../../data/content_manager_api.dart';
import 'mybible_verse_parser.dart';
import '../../data/mybible_book_map.dart';

class MyBibleImporter {
  final ContentStore store;
  
  MyBibleImporter(this.store);

  Future<void> importModuleFile(File sqliteFile, Ph4Module module, ModuleType inferredType) async {
    switch (inferredType) {
      case ModuleType.bible:
        await _importBible(sqliteFile, module);
        break;
      case ModuleType.commentary:
        await _importCommentary(sqliteFile, module);
        break;
      case ModuleType.dictionary:
        await _importDictionary(sqliteFile, module);
        break;
      default:
        print('Skipping unsupported module file type: $inferredType for ${sqliteFile.path}');
    }
  }

  Future<void> _importBible(File sqliteFile, Ph4Module module) async {
    final db = sqlite3.open(sqliteFile.path);

    try {
      String language = 'en';
      final hasInfo = db.select("SELECT name FROM sqlite_master WHERE type='table' AND name='info'").isNotEmpty;
      if (hasInfo) {
        final infoRows = db.select("SELECT value FROM info WHERE name='language'");
        if (infoRows.isNotEmpty) {
          language = infoRows.first['value'] as String;
        }
      }

      final versionId = module.abbr.toUpperCase();
      await store.into(store.versions).insert(VersionsCompanion.insert(
        id: versionId,
        abbreviation: module.abbr,
        name: module.title,
        language: Value(language),
      ), mode: InsertMode.insertOrReplace);

      final Map<int, int> bookIdMap = {};
      final booksQuery = db.select('SELECT book_number, short_name, long_name FROM books ORDER BY book_number');
      
      for (final row in booksQuery) {
        final bookNumber = row['book_number'] as int;
        
        final isNT = bookNumber >= 470;

        final insertedBookId = await store.into(store.books).insert(BooksCompanion.insert(
          versionId: versionId,
          name: _bookNumberToName(bookNumber),
          bookOrder: bookNumber,
          testament: isNT ? 'NT' : 'OT',
        ));
        
        bookIdMap[bookNumber] = insertedBookId;
      }

      final versesQuery = db.select('SELECT book_number, chapter, verse, text FROM verses ORDER BY book_number, chapter, verse');
      
      final parser = MyBibleVerseParser();
      
      await store.batch((batch) {
        for (final row in versesQuery) {
          final bookNumber = row['book_number'] as int;
          final chapter = row['chapter'] as int;
          final verse = row['verse'] as int;
          final text = row['text'] as String;

          final bookId = bookIdMap[bookNumber];
          if (bookId == null) continue;
          
          final segments = parser.parseVerse(text);
          final segmentsJson = jsonEncode(segments.map((s) => s.toJson()).toList());

          batch.insert(store.verses, VersesCompanion.insert(
            bookId: bookId,
            chapter: chapter,
            verse: verse,
            textContent: text,
            segments: segmentsJson, 
          ));
        }
      });
      
    } finally {
      db.dispose();
    }
  }

  Future<void> _importCommentary(File sqliteFile, Ph4Module module) async {
    final db = sqlite3.open(sqliteFile.path);

    try {
      final commentaryId = await store.into(store.commentaries).insert(CommentariesCompanion.insert(
        abbreviation: module.abbr,
        name: module.title,
      ));

      final entriesQuery = db.select('SELECT book_number, chapter_number_from, verse_number_from, text FROM commentaries');
      
      await store.batch((batch) {
        for (final row in entriesQuery) {
          // In mybible commentaries, book_number maps to book name typically, we'll need to resolve it 
          // but for now let's just insert 'Unknown' if we don't have a mapping, or query it.
          // Since mybible commentary has book_number, we can map it to standard names.
          final bookNumber = row['book_number'] as int;
          final chapter = row['chapter_number_from'] as int?;
          final verse = row['verse_number_from'] as int?;
          final text = row['text'] as String;
          
          final bookName = _bookNumberToName(bookNumber);

          batch.insert(store.commentaryEntries, CommentaryEntriesCompanion.insert(
            commentaryId: commentaryId,
            bookName: bookName,
            chapter: Value(chapter == 0 ? null : chapter),
            verse: Value(verse == 0 ? null : verse),
            textContent: text,
          ));
        }
      });
    } finally {
      db.dispose();
    }
  }

  Future<void> _importDictionary(File sqliteFile, Ph4Module module) async {
    final db = sqlite3.open(sqliteFile.path);

    try {
      final dictionaryId = await store.into(store.dictionaries).insert(DictionariesCompanion.insert(
        abbreviation: module.abbr,
        name: module.title,
      ));

      final entriesQuery = db.select('SELECT topic, definition FROM dictionary');
      
      await store.batch((batch) {
        for (final row in entriesQuery) {
          final word = row['topic'] as String;
          final definition = row['definition'] as String;

          batch.insert(store.dictionaryEntries, DictionaryEntriesCompanion.insert(
            dictionaryId: dictionaryId,
            word: word,
            definition: definition,
          ));
        }
      });
    } finally {
      db.dispose();
    }
  }

  String _bookNumberToName(int number) {
    return mybibleBookMap[number] ?? 'Book $number';
  }
}
