import 'dart:convert';
import 'package:sqlite3/sqlite3.dart';
import 'lib/domain/importer/mybible_verse_parser.dart';

void main() {
  final dbPath = '/Users/jessie/Library/Containers/com.example.studyBible/Data/Documents/content.db';
  final db = sqlite3.open(dbPath);
  final parser = MyBibleVerseParser();
  
  final rows = db.select('SELECT id, text_content FROM verses');
  
  db.execute('BEGIN TRANSACTION;');
  final stmt = db.prepare('UPDATE verses SET segments = ? WHERE id = ?');
  
  int count = 0;
  for (final row in rows) {
    final text = row['text_content']?.toString() ?? '';
    final segments = parser.parseVerse(text);
    final segmentsJson = jsonEncode(segments.map((s) => s.toJson()).toList());
    
    stmt.execute([segmentsJson, row['id']]);
    count++;
  }
  
  stmt.dispose();
  db.execute('COMMIT;');
  db.dispose();
  
  print('Updated ${count} verses.');
}
