import 'package:drift/drift.dart';

@DataClassName('Version')
class Versions extends Table {
  TextColumn get id => text()(); // e.g. "KJV"
  TextColumn get abbreviation => text()();
  TextColumn get name => text()();
  TextColumn get language => text().withDefault(const Constant('en'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Book')
class Books extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get versionId => text().references(Versions, #id)();
  TextColumn get name => text()();
  IntColumn get bookOrder => integer()();
  TextColumn get testament => text()(); // "OT" or "NT"
}

@DataClassName('Verse')
class Verses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().references(Books, #id)();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get textContent => text()(); // Plain text for search
  TextColumn get segments => text()(); // JSON string with rich segments
}

@DataClassName('CrossReference')
class CrossReferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceBookName => text()();
  IntColumn get sourceChapter => integer()();
  IntColumn get sourceVerse => integer()();
  
  TextColumn get targetBookName => text()();
  IntColumn get targetChapter => integer()();
  IntColumn get targetVerse => integer()();
}
