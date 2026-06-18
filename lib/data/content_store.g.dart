// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_store.dart';

// ignore_for_file: type=lint
class $VersionsTable extends Versions with TableInfo<$VersionsTable, Version> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abbreviationMeta = const VerificationMeta(
    'abbreviation',
  );
  @override
  late final GeneratedColumn<String> abbreviation = GeneratedColumn<String>(
    'abbreviation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, abbreviation, name, language];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Version> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('abbreviation')) {
      context.handle(
        _abbreviationMeta,
        abbreviation.isAcceptableOrUnknown(
          data['abbreviation']!,
          _abbreviationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_abbreviationMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Version map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Version(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      abbreviation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abbreviation'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
    );
  }

  @override
  $VersionsTable createAlias(String alias) {
    return $VersionsTable(attachedDatabase, alias);
  }
}

class Version extends DataClass implements Insertable<Version> {
  final String id;
  final String abbreviation;
  final String name;
  final String language;
  const Version({
    required this.id,
    required this.abbreviation,
    required this.name,
    required this.language,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['name'] = Variable<String>(name);
    map['language'] = Variable<String>(language);
    return map;
  }

  VersionsCompanion toCompanion(bool nullToAbsent) {
    return VersionsCompanion(
      id: Value(id),
      abbreviation: Value(abbreviation),
      name: Value(name),
      language: Value(language),
    );
  }

  factory Version.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Version(
      id: serializer.fromJson<String>(json['id']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      name: serializer.fromJson<String>(json['name']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'name': serializer.toJson<String>(name),
      'language': serializer.toJson<String>(language),
    };
  }

  Version copyWith({
    String? id,
    String? abbreviation,
    String? name,
    String? language,
  }) => Version(
    id: id ?? this.id,
    abbreviation: abbreviation ?? this.abbreviation,
    name: name ?? this.name,
    language: language ?? this.language,
  );
  Version copyWithCompanion(VersionsCompanion data) {
    return Version(
      id: data.id.present ? data.id.value : this.id,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Version(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abbreviation, name, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Version &&
          other.id == this.id &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.language == this.language);
}

class VersionsCompanion extends UpdateCompanion<Version> {
  final Value<String> id;
  final Value<String> abbreviation;
  final Value<String> name;
  final Value<String> language;
  final Value<int> rowid;
  const VersionsCompanion({
    this.id = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VersionsCompanion.insert({
    required String id,
    required String abbreviation,
    required String name,
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       abbreviation = Value(abbreviation),
       name = Value(name);
  static Insertable<Version> custom({
    Expression<String>? id,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<String>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VersionsCompanion copyWith({
    Value<String>? id,
    Value<String>? abbreviation,
    Value<String>? name,
    Value<String>? language,
    Value<int>? rowid,
  }) {
    return VersionsCompanion(
      id: id ?? this.id,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersionsCompanion(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _versionIdMeta = const VerificationMeta(
    'versionId',
  );
  @override
  late final GeneratedColumn<String> versionId = GeneratedColumn<String>(
    'version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES versions (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookOrderMeta = const VerificationMeta(
    'bookOrder',
  );
  @override
  late final GeneratedColumn<int> bookOrder = GeneratedColumn<int>(
    'book_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testamentMeta = const VerificationMeta(
    'testament',
  );
  @override
  late final GeneratedColumn<String> testament = GeneratedColumn<String>(
    'testament',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    versionId,
    name,
    bookOrder,
    testament,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('version_id')) {
      context.handle(
        _versionIdMeta,
        versionId.isAcceptableOrUnknown(data['version_id']!, _versionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_versionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('book_order')) {
      context.handle(
        _bookOrderMeta,
        bookOrder.isAcceptableOrUnknown(data['book_order']!, _bookOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_bookOrderMeta);
    }
    if (data.containsKey('testament')) {
      context.handle(
        _testamentMeta,
        testament.isAcceptableOrUnknown(data['testament']!, _testamentMeta),
      );
    } else if (isInserting) {
      context.missing(_testamentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      versionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      bookOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_order'],
      )!,
      testament: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}testament'],
      )!,
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final String versionId;
  final String name;
  final int bookOrder;
  final String testament;
  const Book({
    required this.id,
    required this.versionId,
    required this.name,
    required this.bookOrder,
    required this.testament,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version_id'] = Variable<String>(versionId);
    map['name'] = Variable<String>(name);
    map['book_order'] = Variable<int>(bookOrder);
    map['testament'] = Variable<String>(testament);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      versionId: Value(versionId),
      name: Value(name),
      bookOrder: Value(bookOrder),
      testament: Value(testament),
    );
  }

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      versionId: serializer.fromJson<String>(json['versionId']),
      name: serializer.fromJson<String>(json['name']),
      bookOrder: serializer.fromJson<int>(json['bookOrder']),
      testament: serializer.fromJson<String>(json['testament']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'versionId': serializer.toJson<String>(versionId),
      'name': serializer.toJson<String>(name),
      'bookOrder': serializer.toJson<int>(bookOrder),
      'testament': serializer.toJson<String>(testament),
    };
  }

  Book copyWith({
    int? id,
    String? versionId,
    String? name,
    int? bookOrder,
    String? testament,
  }) => Book(
    id: id ?? this.id,
    versionId: versionId ?? this.versionId,
    name: name ?? this.name,
    bookOrder: bookOrder ?? this.bookOrder,
    testament: testament ?? this.testament,
  );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      versionId: data.versionId.present ? data.versionId.value : this.versionId,
      name: data.name.present ? data.name.value : this.name,
      bookOrder: data.bookOrder.present ? data.bookOrder.value : this.bookOrder,
      testament: data.testament.present ? data.testament.value : this.testament,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('versionId: $versionId, ')
          ..write('name: $name, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('testament: $testament')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, versionId, name, bookOrder, testament);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.versionId == this.versionId &&
          other.name == this.name &&
          other.bookOrder == this.bookOrder &&
          other.testament == this.testament);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> versionId;
  final Value<String> name;
  final Value<int> bookOrder;
  final Value<String> testament;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.versionId = const Value.absent(),
    this.name = const Value.absent(),
    this.bookOrder = const Value.absent(),
    this.testament = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String versionId,
    required String name,
    required int bookOrder,
    required String testament,
  }) : versionId = Value(versionId),
       name = Value(name),
       bookOrder = Value(bookOrder),
       testament = Value(testament);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? versionId,
    Expression<String>? name,
    Expression<int>? bookOrder,
    Expression<String>? testament,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (versionId != null) 'version_id': versionId,
      if (name != null) 'name': name,
      if (bookOrder != null) 'book_order': bookOrder,
      if (testament != null) 'testament': testament,
    });
  }

  BooksCompanion copyWith({
    Value<int>? id,
    Value<String>? versionId,
    Value<String>? name,
    Value<int>? bookOrder,
    Value<String>? testament,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      versionId: versionId ?? this.versionId,
      name: name ?? this.name,
      bookOrder: bookOrder ?? this.bookOrder,
      testament: testament ?? this.testament,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (versionId.present) {
      map['version_id'] = Variable<String>(versionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (bookOrder.present) {
      map['book_order'] = Variable<int>(bookOrder.value);
    }
    if (testament.present) {
      map['testament'] = Variable<String>(testament.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('versionId: $versionId, ')
          ..write('name: $name, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('testament: $testament')
          ..write(')'))
        .toString();
  }
}

class $VersesTable extends Verses with TableInfo<$VersesTable, Verse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id)',
    ),
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentsMeta = const VerificationMeta(
    'segments',
  );
  @override
  late final GeneratedColumn<String> segments = GeneratedColumn<String>(
    'segments',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    chapter,
    verse,
    textContent,
    segments,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'verses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Verse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('segments')) {
      context.handle(
        _segmentsMeta,
        segments.isAcceptableOrUnknown(data['segments']!, _segmentsMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Verse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Verse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      segments: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segments'],
      )!,
    );
  }

  @override
  $VersesTable createAlias(String alias) {
    return $VersesTable(attachedDatabase, alias);
  }
}

class Verse extends DataClass implements Insertable<Verse> {
  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String textContent;
  final String segments;
  const Verse({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.textContent,
    required this.segments,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['text_content'] = Variable<String>(textContent);
    map['segments'] = Variable<String>(segments);
    return map;
  }

  VersesCompanion toCompanion(bool nullToAbsent) {
    return VersesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      textContent: Value(textContent),
      segments: Value(segments),
    );
  }

  factory Verse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Verse(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      textContent: serializer.fromJson<String>(json['textContent']),
      segments: serializer.fromJson<String>(json['segments']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'textContent': serializer.toJson<String>(textContent),
      'segments': serializer.toJson<String>(segments),
    };
  }

  Verse copyWith({
    int? id,
    int? bookId,
    int? chapter,
    int? verse,
    String? textContent,
    String? segments,
  }) => Verse(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    textContent: textContent ?? this.textContent,
    segments: segments ?? this.segments,
  );
  Verse copyWithCompanion(VersesCompanion data) {
    return Verse(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      segments: data.segments.present ? data.segments.value : this.segments,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Verse(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent, ')
          ..write('segments: $segments')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, chapter, verse, textContent, segments);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Verse &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.textContent == this.textContent &&
          other.segments == this.segments);
}

class VersesCompanion extends UpdateCompanion<Verse> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String> textContent;
  final Value<String> segments;
  const VersesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.textContent = const Value.absent(),
    this.segments = const Value.absent(),
  });
  VersesCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required int verse,
    required String textContent,
    required String segments,
  }) : bookId = Value(bookId),
       chapter = Value(chapter),
       verse = Value(verse),
       textContent = Value(textContent),
       segments = Value(segments);
  static Insertable<Verse> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? textContent,
    Expression<String>? segments,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (textContent != null) 'text_content': textContent,
      if (segments != null) 'segments': segments,
    });
  }

  VersesCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapter,
    Value<int>? verse,
    Value<String>? textContent,
    Value<String>? segments,
  }) {
    return VersesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      textContent: textContent ?? this.textContent,
      segments: segments ?? this.segments,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (segments.present) {
      map['segments'] = Variable<String>(segments.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent, ')
          ..write('segments: $segments')
          ..write(')'))
        .toString();
  }
}

class $CrossReferencesTable extends CrossReferences
    with TableInfo<$CrossReferencesTable, CrossReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceBookNameMeta = const VerificationMeta(
    'sourceBookName',
  );
  @override
  late final GeneratedColumn<String> sourceBookName = GeneratedColumn<String>(
    'source_book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceChapterMeta = const VerificationMeta(
    'sourceChapter',
  );
  @override
  late final GeneratedColumn<int> sourceChapter = GeneratedColumn<int>(
    'source_chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceVerseMeta = const VerificationMeta(
    'sourceVerse',
  );
  @override
  late final GeneratedColumn<int> sourceVerse = GeneratedColumn<int>(
    'source_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetBookNameMeta = const VerificationMeta(
    'targetBookName',
  );
  @override
  late final GeneratedColumn<String> targetBookName = GeneratedColumn<String>(
    'target_book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetChapterMeta = const VerificationMeta(
    'targetChapter',
  );
  @override
  late final GeneratedColumn<int> targetChapter = GeneratedColumn<int>(
    'target_chapter',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetVerseMeta = const VerificationMeta(
    'targetVerse',
  );
  @override
  late final GeneratedColumn<int> targetVerse = GeneratedColumn<int>(
    'target_verse',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceBookName,
    sourceChapter,
    sourceVerse,
    targetBookName,
    targetChapter,
    targetVerse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cross_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_book_name')) {
      context.handle(
        _sourceBookNameMeta,
        sourceBookName.isAcceptableOrUnknown(
          data['source_book_name']!,
          _sourceBookNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceBookNameMeta);
    }
    if (data.containsKey('source_chapter')) {
      context.handle(
        _sourceChapterMeta,
        sourceChapter.isAcceptableOrUnknown(
          data['source_chapter']!,
          _sourceChapterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceChapterMeta);
    }
    if (data.containsKey('source_verse')) {
      context.handle(
        _sourceVerseMeta,
        sourceVerse.isAcceptableOrUnknown(
          data['source_verse']!,
          _sourceVerseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceVerseMeta);
    }
    if (data.containsKey('target_book_name')) {
      context.handle(
        _targetBookNameMeta,
        targetBookName.isAcceptableOrUnknown(
          data['target_book_name']!,
          _targetBookNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetBookNameMeta);
    }
    if (data.containsKey('target_chapter')) {
      context.handle(
        _targetChapterMeta,
        targetChapter.isAcceptableOrUnknown(
          data['target_chapter']!,
          _targetChapterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetChapterMeta);
    }
    if (data.containsKey('target_verse')) {
      context.handle(
        _targetVerseMeta,
        targetVerse.isAcceptableOrUnknown(
          data['target_verse']!,
          _targetVerseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetVerseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceBookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_book_name'],
      )!,
      sourceChapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_chapter'],
      )!,
      sourceVerse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_verse'],
      )!,
      targetBookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_book_name'],
      )!,
      targetChapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_chapter'],
      )!,
      targetVerse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_verse'],
      )!,
    );
  }

  @override
  $CrossReferencesTable createAlias(String alias) {
    return $CrossReferencesTable(attachedDatabase, alias);
  }
}

class CrossReference extends DataClass implements Insertable<CrossReference> {
  final int id;
  final String sourceBookName;
  final int sourceChapter;
  final int sourceVerse;
  final String targetBookName;
  final int targetChapter;
  final int targetVerse;
  const CrossReference({
    required this.id,
    required this.sourceBookName,
    required this.sourceChapter,
    required this.sourceVerse,
    required this.targetBookName,
    required this.targetChapter,
    required this.targetVerse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_book_name'] = Variable<String>(sourceBookName);
    map['source_chapter'] = Variable<int>(sourceChapter);
    map['source_verse'] = Variable<int>(sourceVerse);
    map['target_book_name'] = Variable<String>(targetBookName);
    map['target_chapter'] = Variable<int>(targetChapter);
    map['target_verse'] = Variable<int>(targetVerse);
    return map;
  }

  CrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return CrossReferencesCompanion(
      id: Value(id),
      sourceBookName: Value(sourceBookName),
      sourceChapter: Value(sourceChapter),
      sourceVerse: Value(sourceVerse),
      targetBookName: Value(targetBookName),
      targetChapter: Value(targetChapter),
      targetVerse: Value(targetVerse),
    );
  }

  factory CrossReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossReference(
      id: serializer.fromJson<int>(json['id']),
      sourceBookName: serializer.fromJson<String>(json['sourceBookName']),
      sourceChapter: serializer.fromJson<int>(json['sourceChapter']),
      sourceVerse: serializer.fromJson<int>(json['sourceVerse']),
      targetBookName: serializer.fromJson<String>(json['targetBookName']),
      targetChapter: serializer.fromJson<int>(json['targetChapter']),
      targetVerse: serializer.fromJson<int>(json['targetVerse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceBookName': serializer.toJson<String>(sourceBookName),
      'sourceChapter': serializer.toJson<int>(sourceChapter),
      'sourceVerse': serializer.toJson<int>(sourceVerse),
      'targetBookName': serializer.toJson<String>(targetBookName),
      'targetChapter': serializer.toJson<int>(targetChapter),
      'targetVerse': serializer.toJson<int>(targetVerse),
    };
  }

  CrossReference copyWith({
    int? id,
    String? sourceBookName,
    int? sourceChapter,
    int? sourceVerse,
    String? targetBookName,
    int? targetChapter,
    int? targetVerse,
  }) => CrossReference(
    id: id ?? this.id,
    sourceBookName: sourceBookName ?? this.sourceBookName,
    sourceChapter: sourceChapter ?? this.sourceChapter,
    sourceVerse: sourceVerse ?? this.sourceVerse,
    targetBookName: targetBookName ?? this.targetBookName,
    targetChapter: targetChapter ?? this.targetChapter,
    targetVerse: targetVerse ?? this.targetVerse,
  );
  CrossReference copyWithCompanion(CrossReferencesCompanion data) {
    return CrossReference(
      id: data.id.present ? data.id.value : this.id,
      sourceBookName: data.sourceBookName.present
          ? data.sourceBookName.value
          : this.sourceBookName,
      sourceChapter: data.sourceChapter.present
          ? data.sourceChapter.value
          : this.sourceChapter,
      sourceVerse: data.sourceVerse.present
          ? data.sourceVerse.value
          : this.sourceVerse,
      targetBookName: data.targetBookName.present
          ? data.targetBookName.value
          : this.targetBookName,
      targetChapter: data.targetChapter.present
          ? data.targetChapter.value
          : this.targetChapter,
      targetVerse: data.targetVerse.present
          ? data.targetVerse.value
          : this.targetVerse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossReference(')
          ..write('id: $id, ')
          ..write('sourceBookName: $sourceBookName, ')
          ..write('sourceChapter: $sourceChapter, ')
          ..write('sourceVerse: $sourceVerse, ')
          ..write('targetBookName: $targetBookName, ')
          ..write('targetChapter: $targetChapter, ')
          ..write('targetVerse: $targetVerse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceBookName,
    sourceChapter,
    sourceVerse,
    targetBookName,
    targetChapter,
    targetVerse,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossReference &&
          other.id == this.id &&
          other.sourceBookName == this.sourceBookName &&
          other.sourceChapter == this.sourceChapter &&
          other.sourceVerse == this.sourceVerse &&
          other.targetBookName == this.targetBookName &&
          other.targetChapter == this.targetChapter &&
          other.targetVerse == this.targetVerse);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReference> {
  final Value<int> id;
  final Value<String> sourceBookName;
  final Value<int> sourceChapter;
  final Value<int> sourceVerse;
  final Value<String> targetBookName;
  final Value<int> targetChapter;
  final Value<int> targetVerse;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.sourceBookName = const Value.absent(),
    this.sourceChapter = const Value.absent(),
    this.sourceVerse = const Value.absent(),
    this.targetBookName = const Value.absent(),
    this.targetChapter = const Value.absent(),
    this.targetVerse = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    this.id = const Value.absent(),
    required String sourceBookName,
    required int sourceChapter,
    required int sourceVerse,
    required String targetBookName,
    required int targetChapter,
    required int targetVerse,
  }) : sourceBookName = Value(sourceBookName),
       sourceChapter = Value(sourceChapter),
       sourceVerse = Value(sourceVerse),
       targetBookName = Value(targetBookName),
       targetChapter = Value(targetChapter),
       targetVerse = Value(targetVerse);
  static Insertable<CrossReference> custom({
    Expression<int>? id,
    Expression<String>? sourceBookName,
    Expression<int>? sourceChapter,
    Expression<int>? sourceVerse,
    Expression<String>? targetBookName,
    Expression<int>? targetChapter,
    Expression<int>? targetVerse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceBookName != null) 'source_book_name': sourceBookName,
      if (sourceChapter != null) 'source_chapter': sourceChapter,
      if (sourceVerse != null) 'source_verse': sourceVerse,
      if (targetBookName != null) 'target_book_name': targetBookName,
      if (targetChapter != null) 'target_chapter': targetChapter,
      if (targetVerse != null) 'target_verse': targetVerse,
    });
  }

  CrossReferencesCompanion copyWith({
    Value<int>? id,
    Value<String>? sourceBookName,
    Value<int>? sourceChapter,
    Value<int>? sourceVerse,
    Value<String>? targetBookName,
    Value<int>? targetChapter,
    Value<int>? targetVerse,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      sourceBookName: sourceBookName ?? this.sourceBookName,
      sourceChapter: sourceChapter ?? this.sourceChapter,
      sourceVerse: sourceVerse ?? this.sourceVerse,
      targetBookName: targetBookName ?? this.targetBookName,
      targetChapter: targetChapter ?? this.targetChapter,
      targetVerse: targetVerse ?? this.targetVerse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceBookName.present) {
      map['source_book_name'] = Variable<String>(sourceBookName.value);
    }
    if (sourceChapter.present) {
      map['source_chapter'] = Variable<int>(sourceChapter.value);
    }
    if (sourceVerse.present) {
      map['source_verse'] = Variable<int>(sourceVerse.value);
    }
    if (targetBookName.present) {
      map['target_book_name'] = Variable<String>(targetBookName.value);
    }
    if (targetChapter.present) {
      map['target_chapter'] = Variable<int>(targetChapter.value);
    }
    if (targetVerse.present) {
      map['target_verse'] = Variable<int>(targetVerse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('sourceBookName: $sourceBookName, ')
          ..write('sourceChapter: $sourceChapter, ')
          ..write('sourceVerse: $sourceVerse, ')
          ..write('targetBookName: $targetBookName, ')
          ..write('targetChapter: $targetChapter, ')
          ..write('targetVerse: $targetVerse')
          ..write(')'))
        .toString();
  }
}

abstract class _$ContentStore extends GeneratedDatabase {
  _$ContentStore(QueryExecutor e) : super(e);
  $ContentStoreManager get managers => $ContentStoreManager(this);
  late final $VersionsTable versions = $VersionsTable(this);
  late final $BooksTable books = $BooksTable(this);
  late final $VersesTable verses = $VersesTable(this);
  late final $CrossReferencesTable crossReferences = $CrossReferencesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    versions,
    books,
    verses,
    crossReferences,
  ];
}

typedef $$VersionsTableCreateCompanionBuilder =
    VersionsCompanion Function({
      required String id,
      required String abbreviation,
      required String name,
      Value<String> language,
      Value<int> rowid,
    });
typedef $$VersionsTableUpdateCompanionBuilder =
    VersionsCompanion Function({
      Value<String> id,
      Value<String> abbreviation,
      Value<String> name,
      Value<String> language,
      Value<int> rowid,
    });

final class $$VersionsTableReferences
    extends BaseReferences<_$ContentStore, $VersionsTable, Version> {
  $$VersionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BooksTable, List<Book>> _booksRefsTable(
    _$ContentStore db,
  ) => MultiTypedResultKey.fromTable(
    db.books,
    aliasName: 'versions__id__books__version_id',
  );

  $$BooksTableProcessedTableManager get booksRefs {
    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.versionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_booksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VersionsTableFilterComposer
    extends Composer<_$ContentStore, $VersionsTable> {
  $$VersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> booksRefs(
    Expression<bool> Function($$BooksTableFilterComposer f) f,
  ) {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.versionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VersionsTableOrderingComposer
    extends Composer<_$ContentStore, $VersionsTable> {
  $$VersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VersionsTableAnnotationComposer
    extends Composer<_$ContentStore, $VersionsTable> {
  $$VersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  Expression<T> booksRefs<T extends Object>(
    Expression<T> Function($$BooksTableAnnotationComposer a) f,
  ) {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.versionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VersionsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $VersionsTable,
          Version,
          $$VersionsTableFilterComposer,
          $$VersionsTableOrderingComposer,
          $$VersionsTableAnnotationComposer,
          $$VersionsTableCreateCompanionBuilder,
          $$VersionsTableUpdateCompanionBuilder,
          (Version, $$VersionsTableReferences),
          Version,
          PrefetchHooks Function({bool booksRefs})
        > {
  $$VersionsTableTableManager(_$ContentStore db, $VersionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> abbreviation = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VersionsCompanion(
                id: id,
                abbreviation: abbreviation,
                name: name,
                language: language,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String abbreviation,
                required String name,
                Value<String> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VersionsCompanion.insert(
                id: id,
                abbreviation: abbreviation,
                name: name,
                language: language,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({booksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (booksRefs) db.books],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (booksRefs)
                    await $_getPrefetchedData<Version, $VersionsTable, Book>(
                      currentTable: table,
                      referencedTable: $$VersionsTableReferences
                          ._booksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VersionsTableReferences(db, table, p0).booksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.versionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $VersionsTable,
      Version,
      $$VersionsTableFilterComposer,
      $$VersionsTableOrderingComposer,
      $$VersionsTableAnnotationComposer,
      $$VersionsTableCreateCompanionBuilder,
      $$VersionsTableUpdateCompanionBuilder,
      (Version, $$VersionsTableReferences),
      Version,
      PrefetchHooks Function({bool booksRefs})
    >;
typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      required String versionId,
      required String name,
      required int bookOrder,
      required String testament,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      Value<String> versionId,
      Value<String> name,
      Value<int> bookOrder,
      Value<String> testament,
    });

final class $$BooksTableReferences
    extends BaseReferences<_$ContentStore, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VersionsTable _versionIdTable(_$ContentStore db) =>
      db.versions.createAlias('books__version_id__versions__id');

  $$VersionsTableProcessedTableManager get versionId {
    final $_column = $_itemColumn<String>('version_id')!;

    final manager = $$VersionsTableTableManager(
      $_db,
      $_db.versions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_versionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VersesTable, List<Verse>> _versesRefsTable(
    _$ContentStore db,
  ) => MultiTypedResultKey.fromTable(
    db.verses,
    aliasName: 'books__id__verses__book_id',
  );

  $$VersesTableProcessedTableManager get versesRefs {
    final manager = $$VersesTableTableManager(
      $_db,
      $_db.verses,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_versesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$ContentStore, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnFilters(column),
  );

  $$VersionsTableFilterComposer get versionId {
    final $$VersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.versionId,
      referencedTable: $db.versions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionsTableFilterComposer(
            $db: $db,
            $table: $db.versions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> versesRefs(
    Expression<bool> Function($$VersesTableFilterComposer f) f,
  ) {
    final $$VersesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.verses,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersesTableFilterComposer(
            $db: $db,
            $table: $db.verses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$ContentStore, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testament => $composableBuilder(
    column: $table.testament,
    builder: (column) => ColumnOrderings(column),
  );

  $$VersionsTableOrderingComposer get versionId {
    final $$VersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.versionId,
      referencedTable: $db.versions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionsTableOrderingComposer(
            $db: $db,
            $table: $db.versions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BooksTableAnnotationComposer
    extends Composer<_$ContentStore, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get bookOrder =>
      $composableBuilder(column: $table.bookOrder, builder: (column) => column);

  GeneratedColumn<String> get testament =>
      $composableBuilder(column: $table.testament, builder: (column) => column);

  $$VersionsTableAnnotationComposer get versionId {
    final $$VersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.versionId,
      referencedTable: $db.versions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.versions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> versesRefs<T extends Object>(
    Expression<T> Function($$VersesTableAnnotationComposer a) f,
  ) {
    final $$VersesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.verses,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VersesTableAnnotationComposer(
            $db: $db,
            $table: $db.verses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, $$BooksTableReferences),
          Book,
          PrefetchHooks Function({bool versionId, bool versesRefs})
        > {
  $$BooksTableTableManager(_$ContentStore db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> versionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> bookOrder = const Value.absent(),
                Value<String> testament = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                versionId: versionId,
                name: name,
                bookOrder: bookOrder,
                testament: testament,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String versionId,
                required String name,
                required int bookOrder,
                required String testament,
              }) => BooksCompanion.insert(
                id: id,
                versionId: versionId,
                name: name,
                bookOrder: bookOrder,
                testament: testament,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BooksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({versionId = false, versesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (versesRefs) db.verses],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (versionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.versionId,
                                referencedTable: $$BooksTableReferences
                                    ._versionIdTable(db),
                                referencedColumn: $$BooksTableReferences
                                    ._versionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (versesRefs)
                    await $_getPrefetchedData<Book, $BooksTable, Verse>(
                      currentTable: table,
                      referencedTable: $$BooksTableReferences._versesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$BooksTableReferences(db, table, p0).versesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bookId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, $$BooksTableReferences),
      Book,
      PrefetchHooks Function({bool versionId, bool versesRefs})
    >;
typedef $$VersesTableCreateCompanionBuilder =
    VersesCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapter,
      required int verse,
      required String textContent,
      required String segments,
    });
typedef $$VersesTableUpdateCompanionBuilder =
    VersesCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapter,
      Value<int> verse,
      Value<String> textContent,
      Value<String> segments,
    });

final class $$VersesTableReferences
    extends BaseReferences<_$ContentStore, $VersesTable, Verse> {
  $$VersesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$ContentStore db) =>
      db.books.createAlias('verses__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VersesTableFilterComposer
    extends Composer<_$ContentStore, $VersesTable> {
  $$VersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VersesTableOrderingComposer
    extends Composer<_$ContentStore, $VersesTable> {
  $$VersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verse => $composableBuilder(
    column: $table.verse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segments => $composableBuilder(
    column: $table.segments,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VersesTableAnnotationComposer
    extends Composer<_$ContentStore, $VersesTable> {
  $$VersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get segments =>
      $composableBuilder(column: $table.segments, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VersesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $VersesTable,
          Verse,
          $$VersesTableFilterComposer,
          $$VersesTableOrderingComposer,
          $$VersesTableAnnotationComposer,
          $$VersesTableCreateCompanionBuilder,
          $$VersesTableUpdateCompanionBuilder,
          (Verse, $$VersesTableReferences),
          Verse,
          PrefetchHooks Function({bool bookId})
        > {
  $$VersesTableTableManager(_$ContentStore db, $VersesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String> segments = const Value.absent(),
              }) => VersesCompanion(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
                segments: segments,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapter,
                required int verse,
                required String textContent,
                required String segments,
              }) => VersesCompanion.insert(
                id: id,
                bookId: bookId,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
                segments: segments,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VersesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$VersesTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$VersesTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VersesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $VersesTable,
      Verse,
      $$VersesTableFilterComposer,
      $$VersesTableOrderingComposer,
      $$VersesTableAnnotationComposer,
      $$VersesTableCreateCompanionBuilder,
      $$VersesTableUpdateCompanionBuilder,
      (Verse, $$VersesTableReferences),
      Verse,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$CrossReferencesTableCreateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      required String sourceBookName,
      required int sourceChapter,
      required int sourceVerse,
      required String targetBookName,
      required int targetChapter,
      required int targetVerse,
    });
typedef $$CrossReferencesTableUpdateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      Value<String> sourceBookName,
      Value<int> sourceChapter,
      Value<int> sourceVerse,
      Value<String> targetBookName,
      Value<int> targetChapter,
      Value<int> targetVerse,
    });

class $$CrossReferencesTableFilterComposer
    extends Composer<_$ContentStore, $CrossReferencesTable> {
  $$CrossReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBookName => $composableBuilder(
    column: $table.sourceBookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceChapter => $composableBuilder(
    column: $table.sourceChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceVerse => $composableBuilder(
    column: $table.sourceVerse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetBookName => $composableBuilder(
    column: $table.targetBookName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetChapter => $composableBuilder(
    column: $table.targetChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetVerse => $composableBuilder(
    column: $table.targetVerse,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CrossReferencesTableOrderingComposer
    extends Composer<_$ContentStore, $CrossReferencesTable> {
  $$CrossReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBookName => $composableBuilder(
    column: $table.sourceBookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceChapter => $composableBuilder(
    column: $table.sourceChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceVerse => $composableBuilder(
    column: $table.sourceVerse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetBookName => $composableBuilder(
    column: $table.targetBookName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetChapter => $composableBuilder(
    column: $table.targetChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetVerse => $composableBuilder(
    column: $table.targetVerse,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CrossReferencesTableAnnotationComposer
    extends Composer<_$ContentStore, $CrossReferencesTable> {
  $$CrossReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceBookName => $composableBuilder(
    column: $table.sourceBookName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourceChapter => $composableBuilder(
    column: $table.sourceChapter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourceVerse => $composableBuilder(
    column: $table.sourceVerse,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetBookName => $composableBuilder(
    column: $table.targetBookName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetChapter => $composableBuilder(
    column: $table.targetChapter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetVerse => $composableBuilder(
    column: $table.targetVerse,
    builder: (column) => column,
  );
}

class $$CrossReferencesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $CrossReferencesTable,
          CrossReference,
          $$CrossReferencesTableFilterComposer,
          $$CrossReferencesTableOrderingComposer,
          $$CrossReferencesTableAnnotationComposer,
          $$CrossReferencesTableCreateCompanionBuilder,
          $$CrossReferencesTableUpdateCompanionBuilder,
          (
            CrossReference,
            BaseReferences<
              _$ContentStore,
              $CrossReferencesTable,
              CrossReference
            >,
          ),
          CrossReference,
          PrefetchHooks Function()
        > {
  $$CrossReferencesTableTableManager(
    _$ContentStore db,
    $CrossReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrossReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrossReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrossReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sourceBookName = const Value.absent(),
                Value<int> sourceChapter = const Value.absent(),
                Value<int> sourceVerse = const Value.absent(),
                Value<String> targetBookName = const Value.absent(),
                Value<int> targetChapter = const Value.absent(),
                Value<int> targetVerse = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                sourceBookName: sourceBookName,
                sourceChapter: sourceChapter,
                sourceVerse: sourceVerse,
                targetBookName: targetBookName,
                targetChapter: targetChapter,
                targetVerse: targetVerse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sourceBookName,
                required int sourceChapter,
                required int sourceVerse,
                required String targetBookName,
                required int targetChapter,
                required int targetVerse,
              }) => CrossReferencesCompanion.insert(
                id: id,
                sourceBookName: sourceBookName,
                sourceChapter: sourceChapter,
                sourceVerse: sourceVerse,
                targetBookName: targetBookName,
                targetChapter: targetChapter,
                targetVerse: targetVerse,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CrossReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $CrossReferencesTable,
      CrossReference,
      $$CrossReferencesTableFilterComposer,
      $$CrossReferencesTableOrderingComposer,
      $$CrossReferencesTableAnnotationComposer,
      $$CrossReferencesTableCreateCompanionBuilder,
      $$CrossReferencesTableUpdateCompanionBuilder,
      (
        CrossReference,
        BaseReferences<_$ContentStore, $CrossReferencesTable, CrossReference>,
      ),
      CrossReference,
      PrefetchHooks Function()
    >;

class $ContentStoreManager {
  final _$ContentStore _db;
  $ContentStoreManager(this._db);
  $$VersionsTableTableManager get versions =>
      $$VersionsTableTableManager(_db, _db.versions);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$VersesTableTableManager get verses =>
      $$VersesTableTableManager(_db, _db.verses);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(_db, _db.crossReferences);
}
