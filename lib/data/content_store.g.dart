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
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    abbreviation,
    name,
    language,
    about,
  ];
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
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
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
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
  final String? about;
  const Version({
    required this.id,
    required this.abbreviation,
    required this.name,
    required this.language,
    this.about,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['name'] = Variable<String>(name);
    map['language'] = Variable<String>(language);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  VersionsCompanion toCompanion(bool nullToAbsent) {
    return VersionsCompanion(
      id: Value(id),
      abbreviation: Value(abbreviation),
      name: Value(name),
      language: Value(language),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
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
      about: serializer.fromJson<String?>(json['about']),
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
      'about': serializer.toJson<String?>(about),
    };
  }

  Version copyWith({
    String? id,
    String? abbreviation,
    String? name,
    String? language,
    Value<String?> about = const Value.absent(),
  }) => Version(
    id: id ?? this.id,
    abbreviation: abbreviation ?? this.abbreviation,
    name: name ?? this.name,
    language: language ?? this.language,
    about: about.present ? about.value : this.about,
  );
  Version copyWithCompanion(VersionsCompanion data) {
    return Version(
      id: data.id.present ? data.id.value : this.id,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      language: data.language.present ? data.language.value : this.language,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Version(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('language: $language, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abbreviation, name, language, about);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Version &&
          other.id == this.id &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.language == this.language &&
          other.about == this.about);
}

class VersionsCompanion extends UpdateCompanion<Version> {
  final Value<String> id;
  final Value<String> abbreviation;
  final Value<String> name;
  final Value<String> language;
  final Value<String?> about;
  final Value<int> rowid;
  const VersionsCompanion({
    this.id = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.language = const Value.absent(),
    this.about = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VersionsCompanion.insert({
    required String id,
    required String abbreviation,
    required String name,
    this.language = const Value.absent(),
    this.about = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       abbreviation = Value(abbreviation),
       name = Value(name);
  static Insertable<Version> custom({
    Expression<String>? id,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<String>? language,
    Expression<String>? about,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
      if (about != null) 'about': about,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VersionsCompanion copyWith({
    Value<String>? id,
    Value<String>? abbreviation,
    Value<String>? name,
    Value<String>? language,
    Value<String?>? about,
    Value<int>? rowid,
  }) {
    return VersionsCompanion(
      id: id ?? this.id,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      language: language ?? this.language,
      about: about ?? this.about,
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
    if (about.present) {
      map['about'] = Variable<String>(about.value);
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
          ..write('about: $about, ')
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
  static const VerificationMeta _votesMeta = const VerificationMeta('votes');
  @override
  late final GeneratedColumn<int> votes = GeneratedColumn<int>(
    'votes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    votes,
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
    if (data.containsKey('votes')) {
      context.handle(
        _votesMeta,
        votes.isAcceptableOrUnknown(data['votes']!, _votesMeta),
      );
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
      votes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}votes'],
      ),
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
  final int? votes;
  const CrossReference({
    required this.id,
    required this.sourceBookName,
    required this.sourceChapter,
    required this.sourceVerse,
    required this.targetBookName,
    required this.targetChapter,
    required this.targetVerse,
    this.votes,
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
    if (!nullToAbsent || votes != null) {
      map['votes'] = Variable<int>(votes);
    }
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
      votes: votes == null && nullToAbsent
          ? const Value.absent()
          : Value(votes),
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
      votes: serializer.fromJson<int?>(json['votes']),
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
      'votes': serializer.toJson<int?>(votes),
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
    Value<int?> votes = const Value.absent(),
  }) => CrossReference(
    id: id ?? this.id,
    sourceBookName: sourceBookName ?? this.sourceBookName,
    sourceChapter: sourceChapter ?? this.sourceChapter,
    sourceVerse: sourceVerse ?? this.sourceVerse,
    targetBookName: targetBookName ?? this.targetBookName,
    targetChapter: targetChapter ?? this.targetChapter,
    targetVerse: targetVerse ?? this.targetVerse,
    votes: votes.present ? votes.value : this.votes,
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
      votes: data.votes.present ? data.votes.value : this.votes,
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
          ..write('targetVerse: $targetVerse, ')
          ..write('votes: $votes')
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
    votes,
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
          other.targetVerse == this.targetVerse &&
          other.votes == this.votes);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReference> {
  final Value<int> id;
  final Value<String> sourceBookName;
  final Value<int> sourceChapter;
  final Value<int> sourceVerse;
  final Value<String> targetBookName;
  final Value<int> targetChapter;
  final Value<int> targetVerse;
  final Value<int?> votes;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.sourceBookName = const Value.absent(),
    this.sourceChapter = const Value.absent(),
    this.sourceVerse = const Value.absent(),
    this.targetBookName = const Value.absent(),
    this.targetChapter = const Value.absent(),
    this.targetVerse = const Value.absent(),
    this.votes = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    this.id = const Value.absent(),
    required String sourceBookName,
    required int sourceChapter,
    required int sourceVerse,
    required String targetBookName,
    required int targetChapter,
    required int targetVerse,
    this.votes = const Value.absent(),
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
    Expression<int>? votes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceBookName != null) 'source_book_name': sourceBookName,
      if (sourceChapter != null) 'source_chapter': sourceChapter,
      if (sourceVerse != null) 'source_verse': sourceVerse,
      if (targetBookName != null) 'target_book_name': targetBookName,
      if (targetChapter != null) 'target_chapter': targetChapter,
      if (targetVerse != null) 'target_verse': targetVerse,
      if (votes != null) 'votes': votes,
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
    Value<int?>? votes,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      sourceBookName: sourceBookName ?? this.sourceBookName,
      sourceChapter: sourceChapter ?? this.sourceChapter,
      sourceVerse: sourceVerse ?? this.sourceVerse,
      targetBookName: targetBookName ?? this.targetBookName,
      targetChapter: targetChapter ?? this.targetChapter,
      targetVerse: targetVerse ?? this.targetVerse,
      votes: votes ?? this.votes,
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
    if (votes.present) {
      map['votes'] = Variable<int>(votes.value);
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
          ..write('targetVerse: $targetVerse, ')
          ..write('votes: $votes')
          ..write(')'))
        .toString();
  }
}

class $CommentariesTable extends Commentaries
    with TableInfo<$CommentariesTable, Commentary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommentariesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, abbreviation, name, about];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commentaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Commentary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Commentary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Commentary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
    );
  }

  @override
  $CommentariesTable createAlias(String alias) {
    return $CommentariesTable(attachedDatabase, alias);
  }
}

class Commentary extends DataClass implements Insertable<Commentary> {
  final int id;
  final String abbreviation;
  final String name;
  final String? about;
  const Commentary({
    required this.id,
    required this.abbreviation,
    required this.name,
    this.about,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  CommentariesCompanion toCompanion(bool nullToAbsent) {
    return CommentariesCompanion(
      id: Value(id),
      abbreviation: Value(abbreviation),
      name: Value(name),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
    );
  }

  factory Commentary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Commentary(
      id: serializer.fromJson<int>(json['id']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String?>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String?>(about),
    };
  }

  Commentary copyWith({
    int? id,
    String? abbreviation,
    String? name,
    Value<String?> about = const Value.absent(),
  }) => Commentary(
    id: id ?? this.id,
    abbreviation: abbreviation ?? this.abbreviation,
    name: name ?? this.name,
    about: about.present ? about.value : this.about,
  );
  Commentary copyWithCompanion(CommentariesCompanion data) {
    return Commentary(
      id: data.id.present ? data.id.value : this.id,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Commentary(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abbreviation, name, about);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Commentary &&
          other.id == this.id &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.about == this.about);
}

class CommentariesCompanion extends UpdateCompanion<Commentary> {
  final Value<int> id;
  final Value<String> abbreviation;
  final Value<String> name;
  final Value<String?> about;
  const CommentariesCompanion({
    this.id = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
  });
  CommentariesCompanion.insert({
    this.id = const Value.absent(),
    required String abbreviation,
    required String name,
    this.about = const Value.absent(),
  }) : abbreviation = Value(abbreviation),
       name = Value(name);
  static Insertable<Commentary> custom({
    Expression<int>? id,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<String>? about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
    });
  }

  CommentariesCompanion copyWith({
    Value<int>? id,
    Value<String>? abbreviation,
    Value<String>? name,
    Value<String?>? about,
  }) {
    return CommentariesCompanion(
      id: id ?? this.id,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      about: about ?? this.about,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentariesCompanion(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }
}

class $CommentaryEntriesTable extends CommentaryEntries
    with TableInfo<$CommentaryEntriesTable, CommentaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommentaryEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _commentaryIdMeta = const VerificationMeta(
    'commentaryId',
  );
  @override
  late final GeneratedColumn<int> commentaryId = GeneratedColumn<int>(
    'commentary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES commentaries (id)',
    ),
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
    'chapter',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
    'verse',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    commentaryId,
    bookName,
    chapter,
    verse,
    textContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commentary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommentaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('commentary_id')) {
      context.handle(
        _commentaryIdMeta,
        commentaryId.isAcceptableOrUnknown(
          data['commentary_id']!,
          _commentaryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_commentaryIdMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    }
    if (data.containsKey('verse')) {
      context.handle(
        _verseMeta,
        verse.isAcceptableOrUnknown(data['verse']!, _verseMeta),
      );
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommentaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommentaryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      commentaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}commentary_id'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      ),
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      ),
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
    );
  }

  @override
  $CommentaryEntriesTable createAlias(String alias) {
    return $CommentaryEntriesTable(attachedDatabase, alias);
  }
}

class CommentaryEntry extends DataClass implements Insertable<CommentaryEntry> {
  final int id;
  final int commentaryId;
  final String bookName;
  final int? chapter;
  final int? verse;
  final String textContent;
  const CommentaryEntry({
    required this.id,
    required this.commentaryId,
    required this.bookName,
    this.chapter,
    this.verse,
    required this.textContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['commentary_id'] = Variable<int>(commentaryId);
    map['book_name'] = Variable<String>(bookName);
    if (!nullToAbsent || chapter != null) {
      map['chapter'] = Variable<int>(chapter);
    }
    if (!nullToAbsent || verse != null) {
      map['verse'] = Variable<int>(verse);
    }
    map['text_content'] = Variable<String>(textContent);
    return map;
  }

  CommentaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return CommentaryEntriesCompanion(
      id: Value(id),
      commentaryId: Value(commentaryId),
      bookName: Value(bookName),
      chapter: chapter == null && nullToAbsent
          ? const Value.absent()
          : Value(chapter),
      verse: verse == null && nullToAbsent
          ? const Value.absent()
          : Value(verse),
      textContent: Value(textContent),
    );
  }

  factory CommentaryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommentaryEntry(
      id: serializer.fromJson<int>(json['id']),
      commentaryId: serializer.fromJson<int>(json['commentaryId']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapter: serializer.fromJson<int?>(json['chapter']),
      verse: serializer.fromJson<int?>(json['verse']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commentaryId': serializer.toJson<int>(commentaryId),
      'bookName': serializer.toJson<String>(bookName),
      'chapter': serializer.toJson<int?>(chapter),
      'verse': serializer.toJson<int?>(verse),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  CommentaryEntry copyWith({
    int? id,
    int? commentaryId,
    String? bookName,
    Value<int?> chapter = const Value.absent(),
    Value<int?> verse = const Value.absent(),
    String? textContent,
  }) => CommentaryEntry(
    id: id ?? this.id,
    commentaryId: commentaryId ?? this.commentaryId,
    bookName: bookName ?? this.bookName,
    chapter: chapter.present ? chapter.value : this.chapter,
    verse: verse.present ? verse.value : this.verse,
    textContent: textContent ?? this.textContent,
  );
  CommentaryEntry copyWithCompanion(CommentaryEntriesCompanion data) {
    return CommentaryEntry(
      id: data.id.present ? data.id.value : this.id,
      commentaryId: data.commentaryId.present
          ? data.commentaryId.value
          : this.commentaryId,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommentaryEntry(')
          ..write('id: $id, ')
          ..write('commentaryId: $commentaryId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, commentaryId, bookName, chapter, verse, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommentaryEntry &&
          other.id == this.id &&
          other.commentaryId == this.commentaryId &&
          other.bookName == this.bookName &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.textContent == this.textContent);
}

class CommentaryEntriesCompanion extends UpdateCompanion<CommentaryEntry> {
  final Value<int> id;
  final Value<int> commentaryId;
  final Value<String> bookName;
  final Value<int?> chapter;
  final Value<int?> verse;
  final Value<String> textContent;
  const CommentaryEntriesCompanion({
    this.id = const Value.absent(),
    this.commentaryId = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.textContent = const Value.absent(),
  });
  CommentaryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int commentaryId,
    required String bookName,
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    required String textContent,
  }) : commentaryId = Value(commentaryId),
       bookName = Value(bookName),
       textContent = Value(textContent);
  static Insertable<CommentaryEntry> custom({
    Expression<int>? id,
    Expression<int>? commentaryId,
    Expression<String>? bookName,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? textContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commentaryId != null) 'commentary_id': commentaryId,
      if (bookName != null) 'book_name': bookName,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (textContent != null) 'text_content': textContent,
    });
  }

  CommentaryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? commentaryId,
    Value<String>? bookName,
    Value<int?>? chapter,
    Value<int?>? verse,
    Value<String>? textContent,
  }) {
    return CommentaryEntriesCompanion(
      id: id ?? this.id,
      commentaryId: commentaryId ?? this.commentaryId,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      textContent: textContent ?? this.textContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commentaryId.present) {
      map['commentary_id'] = Variable<int>(commentaryId.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('commentaryId: $commentaryId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }
}

class $DictionariesTable extends Dictionaries
    with TableInfo<$DictionariesTable, Dictionary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionariesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, abbreviation, name, about];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictionaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dictionary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dictionary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dictionary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
    );
  }

  @override
  $DictionariesTable createAlias(String alias) {
    return $DictionariesTable(attachedDatabase, alias);
  }
}

class Dictionary extends DataClass implements Insertable<Dictionary> {
  final int id;
  final String abbreviation;
  final String name;
  final String? about;
  const Dictionary({
    required this.id,
    required this.abbreviation,
    required this.name,
    this.about,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  DictionariesCompanion toCompanion(bool nullToAbsent) {
    return DictionariesCompanion(
      id: Value(id),
      abbreviation: Value(abbreviation),
      name: Value(name),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
    );
  }

  factory Dictionary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dictionary(
      id: serializer.fromJson<int>(json['id']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String?>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String?>(about),
    };
  }

  Dictionary copyWith({
    int? id,
    String? abbreviation,
    String? name,
    Value<String?> about = const Value.absent(),
  }) => Dictionary(
    id: id ?? this.id,
    abbreviation: abbreviation ?? this.abbreviation,
    name: name ?? this.name,
    about: about.present ? about.value : this.about,
  );
  Dictionary copyWithCompanion(DictionariesCompanion data) {
    return Dictionary(
      id: data.id.present ? data.id.value : this.id,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dictionary(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abbreviation, name, about);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dictionary &&
          other.id == this.id &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.about == this.about);
}

class DictionariesCompanion extends UpdateCompanion<Dictionary> {
  final Value<int> id;
  final Value<String> abbreviation;
  final Value<String> name;
  final Value<String?> about;
  const DictionariesCompanion({
    this.id = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
  });
  DictionariesCompanion.insert({
    this.id = const Value.absent(),
    required String abbreviation,
    required String name,
    this.about = const Value.absent(),
  }) : abbreviation = Value(abbreviation),
       name = Value(name);
  static Insertable<Dictionary> custom({
    Expression<int>? id,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<String>? about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
    });
  }

  DictionariesCompanion copyWith({
    Value<int>? id,
    Value<String>? abbreviation,
    Value<String>? name,
    Value<String?>? about,
  }) {
    return DictionariesCompanion(
      id: id ?? this.id,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      about: about ?? this.about,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionariesCompanion(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }
}

class $DictionaryEntriesTable extends DictionaryEntries
    with TableInfo<$DictionaryEntriesTable, DictionaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionaryEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dictionaryIdMeta = const VerificationMeta(
    'dictionaryId',
  );
  @override
  late final GeneratedColumn<int> dictionaryId = GeneratedColumn<int>(
    'dictionary_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dictionaries (id)',
    ),
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionMeta = const VerificationMeta(
    'definition',
  );
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
    'definition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, dictionaryId, word, definition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictionary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DictionaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dictionary_id')) {
      context.handle(
        _dictionaryIdMeta,
        dictionaryId.isAcceptableOrUnknown(
          data['dictionary_id']!,
          _dictionaryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictionaryIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
        _definitionMeta,
        definition.isAcceptableOrUnknown(data['definition']!, _definitionMeta),
      );
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DictionaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictionaryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dictionaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dictionary_id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      definition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition'],
      )!,
    );
  }

  @override
  $DictionaryEntriesTable createAlias(String alias) {
    return $DictionaryEntriesTable(attachedDatabase, alias);
  }
}

class DictionaryEntry extends DataClass implements Insertable<DictionaryEntry> {
  final int id;
  final int dictionaryId;
  final String word;
  final String definition;
  const DictionaryEntry({
    required this.id,
    required this.dictionaryId,
    required this.word,
    required this.definition,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dictionary_id'] = Variable<int>(dictionaryId);
    map['word'] = Variable<String>(word);
    map['definition'] = Variable<String>(definition);
    return map;
  }

  DictionaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DictionaryEntriesCompanion(
      id: Value(id),
      dictionaryId: Value(dictionaryId),
      word: Value(word),
      definition: Value(definition),
    );
  }

  factory DictionaryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictionaryEntry(
      id: serializer.fromJson<int>(json['id']),
      dictionaryId: serializer.fromJson<int>(json['dictionaryId']),
      word: serializer.fromJson<String>(json['word']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dictionaryId': serializer.toJson<int>(dictionaryId),
      'word': serializer.toJson<String>(word),
      'definition': serializer.toJson<String>(definition),
    };
  }

  DictionaryEntry copyWith({
    int? id,
    int? dictionaryId,
    String? word,
    String? definition,
  }) => DictionaryEntry(
    id: id ?? this.id,
    dictionaryId: dictionaryId ?? this.dictionaryId,
    word: word ?? this.word,
    definition: definition ?? this.definition,
  );
  DictionaryEntry copyWithCompanion(DictionaryEntriesCompanion data) {
    return DictionaryEntry(
      id: data.id.present ? data.id.value : this.id,
      dictionaryId: data.dictionaryId.present
          ? data.dictionaryId.value
          : this.dictionaryId,
      word: data.word.present ? data.word.value : this.word,
      definition: data.definition.present
          ? data.definition.value
          : this.definition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntry(')
          ..write('id: $id, ')
          ..write('dictionaryId: $dictionaryId, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dictionaryId, word, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryEntry &&
          other.id == this.id &&
          other.dictionaryId == this.dictionaryId &&
          other.word == this.word &&
          other.definition == this.definition);
}

class DictionaryEntriesCompanion extends UpdateCompanion<DictionaryEntry> {
  final Value<int> id;
  final Value<int> dictionaryId;
  final Value<String> word;
  final Value<String> definition;
  const DictionaryEntriesCompanion({
    this.id = const Value.absent(),
    this.dictionaryId = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
  });
  DictionaryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int dictionaryId,
    required String word,
    required String definition,
  }) : dictionaryId = Value(dictionaryId),
       word = Value(word),
       definition = Value(definition);
  static Insertable<DictionaryEntry> custom({
    Expression<int>? id,
    Expression<int>? dictionaryId,
    Expression<String>? word,
    Expression<String>? definition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dictionaryId != null) 'dictionary_id': dictionaryId,
      if (word != null) 'word': word,
      if (definition != null) 'definition': definition,
    });
  }

  DictionaryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? dictionaryId,
    Value<String>? word,
    Value<String>? definition,
  }) {
    return DictionaryEntriesCompanion(
      id: id ?? this.id,
      dictionaryId: dictionaryId ?? this.dictionaryId,
      word: word ?? this.word,
      definition: definition ?? this.definition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dictionaryId.present) {
      map['dictionary_id'] = Variable<int>(dictionaryId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('dictionaryId: $dictionaryId, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }
}

class $SubheadingsTable extends Subheadings
    with TableInfo<$SubheadingsTable, Subheading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubheadingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _orderIfSeveralMeta = const VerificationMeta(
    'orderIfSeveral',
  );
  @override
  late final GeneratedColumn<int> orderIfSeveral = GeneratedColumn<int>(
    'order_if_several',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    versionId,
    bookOrder,
    chapter,
    verse,
    orderIfSeveral,
    textContent,
    about,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subheadings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subheading> instance, {
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
    if (data.containsKey('book_order')) {
      context.handle(
        _bookOrderMeta,
        bookOrder.isAcceptableOrUnknown(data['book_order']!, _bookOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_bookOrderMeta);
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
    if (data.containsKey('order_if_several')) {
      context.handle(
        _orderIfSeveralMeta,
        orderIfSeveral.isAcceptableOrUnknown(
          data['order_if_several']!,
          _orderIfSeveralMeta,
        ),
      );
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subheading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subheading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      versionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version_id'],
      )!,
      bookOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_order'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
      orderIfSeveral: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_if_several'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
    );
  }

  @override
  $SubheadingsTable createAlias(String alias) {
    return $SubheadingsTable(attachedDatabase, alias);
  }
}

class Subheading extends DataClass implements Insertable<Subheading> {
  final int id;
  final String versionId;
  final int bookOrder;
  final int chapter;
  final int verse;
  final int orderIfSeveral;
  final String textContent;
  final String? about;
  const Subheading({
    required this.id,
    required this.versionId,
    required this.bookOrder,
    required this.chapter,
    required this.verse,
    required this.orderIfSeveral,
    required this.textContent,
    this.about,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version_id'] = Variable<String>(versionId);
    map['book_order'] = Variable<int>(bookOrder);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    map['order_if_several'] = Variable<int>(orderIfSeveral);
    map['text_content'] = Variable<String>(textContent);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  SubheadingsCompanion toCompanion(bool nullToAbsent) {
    return SubheadingsCompanion(
      id: Value(id),
      versionId: Value(versionId),
      bookOrder: Value(bookOrder),
      chapter: Value(chapter),
      verse: Value(verse),
      orderIfSeveral: Value(orderIfSeveral),
      textContent: Value(textContent),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
    );
  }

  factory Subheading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subheading(
      id: serializer.fromJson<int>(json['id']),
      versionId: serializer.fromJson<String>(json['versionId']),
      bookOrder: serializer.fromJson<int>(json['bookOrder']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      orderIfSeveral: serializer.fromJson<int>(json['orderIfSeveral']),
      textContent: serializer.fromJson<String>(json['textContent']),
      about: serializer.fromJson<String?>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'versionId': serializer.toJson<String>(versionId),
      'bookOrder': serializer.toJson<int>(bookOrder),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'orderIfSeveral': serializer.toJson<int>(orderIfSeveral),
      'textContent': serializer.toJson<String>(textContent),
      'about': serializer.toJson<String?>(about),
    };
  }

  Subheading copyWith({
    int? id,
    String? versionId,
    int? bookOrder,
    int? chapter,
    int? verse,
    int? orderIfSeveral,
    String? textContent,
    Value<String?> about = const Value.absent(),
  }) => Subheading(
    id: id ?? this.id,
    versionId: versionId ?? this.versionId,
    bookOrder: bookOrder ?? this.bookOrder,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
    orderIfSeveral: orderIfSeveral ?? this.orderIfSeveral,
    textContent: textContent ?? this.textContent,
    about: about.present ? about.value : this.about,
  );
  Subheading copyWithCompanion(SubheadingsCompanion data) {
    return Subheading(
      id: data.id.present ? data.id.value : this.id,
      versionId: data.versionId.present ? data.versionId.value : this.versionId,
      bookOrder: data.bookOrder.present ? data.bookOrder.value : this.bookOrder,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      orderIfSeveral: data.orderIfSeveral.present
          ? data.orderIfSeveral.value
          : this.orderIfSeveral,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subheading(')
          ..write('id: $id, ')
          ..write('versionId: $versionId, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('orderIfSeveral: $orderIfSeveral, ')
          ..write('textContent: $textContent, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    versionId,
    bookOrder,
    chapter,
    verse,
    orderIfSeveral,
    textContent,
    about,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subheading &&
          other.id == this.id &&
          other.versionId == this.versionId &&
          other.bookOrder == this.bookOrder &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.orderIfSeveral == this.orderIfSeveral &&
          other.textContent == this.textContent &&
          other.about == this.about);
}

class SubheadingsCompanion extends UpdateCompanion<Subheading> {
  final Value<int> id;
  final Value<String> versionId;
  final Value<int> bookOrder;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<int> orderIfSeveral;
  final Value<String> textContent;
  final Value<String?> about;
  const SubheadingsCompanion({
    this.id = const Value.absent(),
    this.versionId = const Value.absent(),
    this.bookOrder = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.orderIfSeveral = const Value.absent(),
    this.textContent = const Value.absent(),
    this.about = const Value.absent(),
  });
  SubheadingsCompanion.insert({
    this.id = const Value.absent(),
    required String versionId,
    required int bookOrder,
    required int chapter,
    required int verse,
    this.orderIfSeveral = const Value.absent(),
    required String textContent,
    this.about = const Value.absent(),
  }) : versionId = Value(versionId),
       bookOrder = Value(bookOrder),
       chapter = Value(chapter),
       verse = Value(verse),
       textContent = Value(textContent);
  static Insertable<Subheading> custom({
    Expression<int>? id,
    Expression<String>? versionId,
    Expression<int>? bookOrder,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<int>? orderIfSeveral,
    Expression<String>? textContent,
    Expression<String>? about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (versionId != null) 'version_id': versionId,
      if (bookOrder != null) 'book_order': bookOrder,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (orderIfSeveral != null) 'order_if_several': orderIfSeveral,
      if (textContent != null) 'text_content': textContent,
      if (about != null) 'about': about,
    });
  }

  SubheadingsCompanion copyWith({
    Value<int>? id,
    Value<String>? versionId,
    Value<int>? bookOrder,
    Value<int>? chapter,
    Value<int>? verse,
    Value<int>? orderIfSeveral,
    Value<String>? textContent,
    Value<String?>? about,
  }) {
    return SubheadingsCompanion(
      id: id ?? this.id,
      versionId: versionId ?? this.versionId,
      bookOrder: bookOrder ?? this.bookOrder,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      orderIfSeveral: orderIfSeveral ?? this.orderIfSeveral,
      textContent: textContent ?? this.textContent,
      about: about ?? this.about,
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
    if (bookOrder.present) {
      map['book_order'] = Variable<int>(bookOrder.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (orderIfSeveral.present) {
      map['order_if_several'] = Variable<int>(orderIfSeveral.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubheadingsCompanion(')
          ..write('id: $id, ')
          ..write('versionId: $versionId, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('orderIfSeveral: $orderIfSeveral, ')
          ..write('textContent: $textContent, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }
}

class $DevotionalsTable extends Devotionals
    with TableInfo<$DevotionalsTable, Devotional> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevotionalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String> about = GeneratedColumn<String>(
    'about',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, abbreviation, name, about];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devotionals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Devotional> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('about')) {
      context.handle(
        _aboutMeta,
        about.isAcceptableOrUnknown(data['about']!, _aboutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Devotional map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Devotional(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
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
      about: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}about'],
      ),
    );
  }

  @override
  $DevotionalsTable createAlias(String alias) {
    return $DevotionalsTable(attachedDatabase, alias);
  }
}

class Devotional extends DataClass implements Insertable<Devotional> {
  final int id;
  final String abbreviation;
  final String name;
  final String? about;
  const Devotional({
    required this.id,
    required this.abbreviation,
    required this.name,
    this.about,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || about != null) {
      map['about'] = Variable<String>(about);
    }
    return map;
  }

  DevotionalsCompanion toCompanion(bool nullToAbsent) {
    return DevotionalsCompanion(
      id: Value(id),
      abbreviation: Value(abbreviation),
      name: Value(name),
      about: about == null && nullToAbsent
          ? const Value.absent()
          : Value(about),
    );
  }

  factory Devotional.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Devotional(
      id: serializer.fromJson<int>(json['id']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      name: serializer.fromJson<String>(json['name']),
      about: serializer.fromJson<String?>(json['about']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'name': serializer.toJson<String>(name),
      'about': serializer.toJson<String?>(about),
    };
  }

  Devotional copyWith({
    int? id,
    String? abbreviation,
    String? name,
    Value<String?> about = const Value.absent(),
  }) => Devotional(
    id: id ?? this.id,
    abbreviation: abbreviation ?? this.abbreviation,
    name: name ?? this.name,
    about: about.present ? about.value : this.about,
  );
  Devotional copyWithCompanion(DevotionalsCompanion data) {
    return Devotional(
      id: data.id.present ? data.id.value : this.id,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      about: data.about.present ? data.about.value : this.about,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Devotional(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, abbreviation, name, about);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Devotional &&
          other.id == this.id &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.about == this.about);
}

class DevotionalsCompanion extends UpdateCompanion<Devotional> {
  final Value<int> id;
  final Value<String> abbreviation;
  final Value<String> name;
  final Value<String?> about;
  const DevotionalsCompanion({
    this.id = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.about = const Value.absent(),
  });
  DevotionalsCompanion.insert({
    this.id = const Value.absent(),
    required String abbreviation,
    required String name,
    this.about = const Value.absent(),
  }) : abbreviation = Value(abbreviation),
       name = Value(name);
  static Insertable<Devotional> custom({
    Expression<int>? id,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<String>? about,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (about != null) 'about': about,
    });
  }

  DevotionalsCompanion copyWith({
    Value<int>? id,
    Value<String>? abbreviation,
    Value<String>? name,
    Value<String?>? about,
  }) {
    return DevotionalsCompanion(
      id: id ?? this.id,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      about: about ?? this.about,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevotionalsCompanion(')
          ..write('id: $id, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('about: $about')
          ..write(')'))
        .toString();
  }
}

class $DevotionalEntriesTable extends DevotionalEntries
    with TableInfo<$DevotionalEntriesTable, DevotionalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevotionalEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _devotionalIdMeta = const VerificationMeta(
    'devotionalId',
  );
  @override
  late final GeneratedColumn<int> devotionalId = GeneratedColumn<int>(
    'devotional_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES devotionals (id)',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
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
  @override
  List<GeneratedColumn> get $columns => [id, devotionalId, day, textContent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devotional_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DevotionalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('devotional_id')) {
      context.handle(
        _devotionalIdMeta,
        devotionalId.isAcceptableOrUnknown(
          data['devotional_id']!,
          _devotionalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_devotionalIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DevotionalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DevotionalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      devotionalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}devotional_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
    );
  }

  @override
  $DevotionalEntriesTable createAlias(String alias) {
    return $DevotionalEntriesTable(attachedDatabase, alias);
  }
}

class DevotionalEntry extends DataClass implements Insertable<DevotionalEntry> {
  final int id;
  final int devotionalId;
  final int day;
  final String textContent;
  const DevotionalEntry({
    required this.id,
    required this.devotionalId,
    required this.day,
    required this.textContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['devotional_id'] = Variable<int>(devotionalId);
    map['day'] = Variable<int>(day);
    map['text_content'] = Variable<String>(textContent);
    return map;
  }

  DevotionalEntriesCompanion toCompanion(bool nullToAbsent) {
    return DevotionalEntriesCompanion(
      id: Value(id),
      devotionalId: Value(devotionalId),
      day: Value(day),
      textContent: Value(textContent),
    );
  }

  factory DevotionalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DevotionalEntry(
      id: serializer.fromJson<int>(json['id']),
      devotionalId: serializer.fromJson<int>(json['devotionalId']),
      day: serializer.fromJson<int>(json['day']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'devotionalId': serializer.toJson<int>(devotionalId),
      'day': serializer.toJson<int>(day),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  DevotionalEntry copyWith({
    int? id,
    int? devotionalId,
    int? day,
    String? textContent,
  }) => DevotionalEntry(
    id: id ?? this.id,
    devotionalId: devotionalId ?? this.devotionalId,
    day: day ?? this.day,
    textContent: textContent ?? this.textContent,
  );
  DevotionalEntry copyWithCompanion(DevotionalEntriesCompanion data) {
    return DevotionalEntry(
      id: data.id.present ? data.id.value : this.id,
      devotionalId: data.devotionalId.present
          ? data.devotionalId.value
          : this.devotionalId,
      day: data.day.present ? data.day.value : this.day,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DevotionalEntry(')
          ..write('id: $id, ')
          ..write('devotionalId: $devotionalId, ')
          ..write('day: $day, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, devotionalId, day, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DevotionalEntry &&
          other.id == this.id &&
          other.devotionalId == this.devotionalId &&
          other.day == this.day &&
          other.textContent == this.textContent);
}

class DevotionalEntriesCompanion extends UpdateCompanion<DevotionalEntry> {
  final Value<int> id;
  final Value<int> devotionalId;
  final Value<int> day;
  final Value<String> textContent;
  const DevotionalEntriesCompanion({
    this.id = const Value.absent(),
    this.devotionalId = const Value.absent(),
    this.day = const Value.absent(),
    this.textContent = const Value.absent(),
  });
  DevotionalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int devotionalId,
    required int day,
    required String textContent,
  }) : devotionalId = Value(devotionalId),
       day = Value(day),
       textContent = Value(textContent);
  static Insertable<DevotionalEntry> custom({
    Expression<int>? id,
    Expression<int>? devotionalId,
    Expression<int>? day,
    Expression<String>? textContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (devotionalId != null) 'devotional_id': devotionalId,
      if (day != null) 'day': day,
      if (textContent != null) 'text_content': textContent,
    });
  }

  DevotionalEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? devotionalId,
    Value<int>? day,
    Value<String>? textContent,
  }) {
    return DevotionalEntriesCompanion(
      id: id ?? this.id,
      devotionalId: devotionalId ?? this.devotionalId,
      day: day ?? this.day,
      textContent: textContent ?? this.textContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (devotionalId.present) {
      map['devotional_id'] = Variable<int>(devotionalId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevotionalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('devotionalId: $devotionalId, ')
          ..write('day: $day, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, section];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      )!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final String name;
  final String section;
  const Topic({required this.id, required this.name, required this.section});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['section'] = Variable<String>(section);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      name: Value(name),
      section: Value(section),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      section: serializer.fromJson<String>(json['section']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'section': serializer.toJson<String>(section),
    };
  }

  Topic copyWith({int? id, String? name, String? section}) => Topic(
    id: id ?? this.id,
    name: name ?? this.name,
    section: section ?? this.section,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      section: data.section.present ? data.section.value : this.section,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('section: $section')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, section);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.name == this.name &&
          other.section == this.section);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> section;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.section = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String section,
  }) : name = Value(name),
       section = Value(section);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? section,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (section != null) 'section': section,
    });
  }

  TopicsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? section,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      section: section ?? this.section,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('section: $section')
          ..write(')'))
        .toString();
  }
}

class $TopicEntriesTable extends TopicEntries
    with TableInfo<$TopicEntriesTable, TopicEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seeAlsoMeta = const VerificationMeta(
    'seeAlso',
  );
  @override
  late final GeneratedColumn<String> seeAlso = GeneratedColumn<String>(
    'see_also',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    ordinal,
    description,
    seeAlso,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('see_also')) {
      context.handle(
        _seeAlsoMeta,
        seeAlso.isAcceptableOrUnknown(data['see_also']!, _seeAlsoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      seeAlso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}see_also'],
      ),
    );
  }

  @override
  $TopicEntriesTable createAlias(String alias) {
    return $TopicEntriesTable(attachedDatabase, alias);
  }
}

class TopicEntry extends DataClass implements Insertable<TopicEntry> {
  final int id;
  final int topicId;
  final int ordinal;
  final String description;
  final String? seeAlso;
  const TopicEntry({
    required this.id,
    required this.topicId,
    required this.ordinal,
    required this.description,
    this.seeAlso,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    map['ordinal'] = Variable<int>(ordinal);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || seeAlso != null) {
      map['see_also'] = Variable<String>(seeAlso);
    }
    return map;
  }

  TopicEntriesCompanion toCompanion(bool nullToAbsent) {
    return TopicEntriesCompanion(
      id: Value(id),
      topicId: Value(topicId),
      ordinal: Value(ordinal),
      description: Value(description),
      seeAlso: seeAlso == null && nullToAbsent
          ? const Value.absent()
          : Value(seeAlso),
    );
  }

  factory TopicEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicEntry(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      description: serializer.fromJson<String>(json['description']),
      seeAlso: serializer.fromJson<String?>(json['seeAlso']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'ordinal': serializer.toJson<int>(ordinal),
      'description': serializer.toJson<String>(description),
      'seeAlso': serializer.toJson<String?>(seeAlso),
    };
  }

  TopicEntry copyWith({
    int? id,
    int? topicId,
    int? ordinal,
    String? description,
    Value<String?> seeAlso = const Value.absent(),
  }) => TopicEntry(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    ordinal: ordinal ?? this.ordinal,
    description: description ?? this.description,
    seeAlso: seeAlso.present ? seeAlso.value : this.seeAlso,
  );
  TopicEntry copyWithCompanion(TopicEntriesCompanion data) {
    return TopicEntry(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      description: data.description.present
          ? data.description.value
          : this.description,
      seeAlso: data.seeAlso.present ? data.seeAlso.value : this.seeAlso,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicEntry(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('ordinal: $ordinal, ')
          ..write('description: $description, ')
          ..write('seeAlso: $seeAlso')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, topicId, ordinal, description, seeAlso);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicEntry &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.ordinal == this.ordinal &&
          other.description == this.description &&
          other.seeAlso == this.seeAlso);
}

class TopicEntriesCompanion extends UpdateCompanion<TopicEntry> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<int> ordinal;
  final Value<String> description;
  final Value<String?> seeAlso;
  const TopicEntriesCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.description = const Value.absent(),
    this.seeAlso = const Value.absent(),
  });
  TopicEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required int ordinal,
    required String description,
    this.seeAlso = const Value.absent(),
  }) : topicId = Value(topicId),
       ordinal = Value(ordinal),
       description = Value(description);
  static Insertable<TopicEntry> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<int>? ordinal,
    Expression<String>? description,
    Expression<String>? seeAlso,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (ordinal != null) 'ordinal': ordinal,
      if (description != null) 'description': description,
      if (seeAlso != null) 'see_also': seeAlso,
    });
  }

  TopicEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<int>? ordinal,
    Value<String>? description,
    Value<String?>? seeAlso,
  }) {
    return TopicEntriesCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      ordinal: ordinal ?? this.ordinal,
      description: description ?? this.description,
      seeAlso: seeAlso ?? this.seeAlso,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (seeAlso.present) {
      map['see_also'] = Variable<String>(seeAlso.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicEntriesCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('ordinal: $ordinal, ')
          ..write('description: $description, ')
          ..write('seeAlso: $seeAlso')
          ..write(')'))
        .toString();
  }
}

class $TopicReferencesTable extends TopicReferences
    with TableInfo<$TopicReferencesTable, TopicReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicReferencesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topic_entries (id)',
    ),
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verseEndMeta = const VerificationMeta(
    'verseEnd',
  );
  @override
  late final GeneratedColumn<int> verseEnd = GeneratedColumn<int>(
    'verse_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    entryId,
    bookName,
    chapter,
    verse,
    verseEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
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
    }
    if (data.containsKey('verse_end')) {
      context.handle(
        _verseEndMeta,
        verseEnd.isAcceptableOrUnknown(data['verse_end']!, _verseEndMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      ),
      verseEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_end'],
      ),
    );
  }

  @override
  $TopicReferencesTable createAlias(String alias) {
    return $TopicReferencesTable(attachedDatabase, alias);
  }
}

class TopicReference extends DataClass implements Insertable<TopicReference> {
  final int id;
  final int topicId;
  final int entryId;
  final String bookName;
  final int chapter;
  final int? verse;
  final int? verseEnd;
  const TopicReference({
    required this.id,
    required this.topicId,
    required this.entryId,
    required this.bookName,
    required this.chapter,
    this.verse,
    this.verseEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    map['entry_id'] = Variable<int>(entryId);
    map['book_name'] = Variable<String>(bookName);
    map['chapter'] = Variable<int>(chapter);
    if (!nullToAbsent || verse != null) {
      map['verse'] = Variable<int>(verse);
    }
    if (!nullToAbsent || verseEnd != null) {
      map['verse_end'] = Variable<int>(verseEnd);
    }
    return map;
  }

  TopicReferencesCompanion toCompanion(bool nullToAbsent) {
    return TopicReferencesCompanion(
      id: Value(id),
      topicId: Value(topicId),
      entryId: Value(entryId),
      bookName: Value(bookName),
      chapter: Value(chapter),
      verse: verse == null && nullToAbsent
          ? const Value.absent()
          : Value(verse),
      verseEnd: verseEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(verseEnd),
    );
  }

  factory TopicReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicReference(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      entryId: serializer.fromJson<int>(json['entryId']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int?>(json['verse']),
      verseEnd: serializer.fromJson<int?>(json['verseEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'entryId': serializer.toJson<int>(entryId),
      'bookName': serializer.toJson<String>(bookName),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int?>(verse),
      'verseEnd': serializer.toJson<int?>(verseEnd),
    };
  }

  TopicReference copyWith({
    int? id,
    int? topicId,
    int? entryId,
    String? bookName,
    int? chapter,
    Value<int?> verse = const Value.absent(),
    Value<int?> verseEnd = const Value.absent(),
  }) => TopicReference(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    entryId: entryId ?? this.entryId,
    bookName: bookName ?? this.bookName,
    chapter: chapter ?? this.chapter,
    verse: verse.present ? verse.value : this.verse,
    verseEnd: verseEnd.present ? verseEnd.value : this.verseEnd,
  );
  TopicReference copyWithCompanion(TopicReferencesCompanion data) {
    return TopicReference(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      verseEnd: data.verseEnd.present ? data.verseEnd.value : this.verseEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicReference(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('entryId: $entryId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('verseEnd: $verseEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, topicId, entryId, bookName, chapter, verse, verseEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicReference &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.entryId == this.entryId &&
          other.bookName == this.bookName &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.verseEnd == this.verseEnd);
}

class TopicReferencesCompanion extends UpdateCompanion<TopicReference> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<int> entryId;
  final Value<String> bookName;
  final Value<int> chapter;
  final Value<int?> verse;
  final Value<int?> verseEnd;
  const TopicReferencesCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.verseEnd = const Value.absent(),
  });
  TopicReferencesCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required int entryId,
    required String bookName,
    required int chapter,
    this.verse = const Value.absent(),
    this.verseEnd = const Value.absent(),
  }) : topicId = Value(topicId),
       entryId = Value(entryId),
       bookName = Value(bookName),
       chapter = Value(chapter);
  static Insertable<TopicReference> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<int>? entryId,
    Expression<String>? bookName,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<int>? verseEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (entryId != null) 'entry_id': entryId,
      if (bookName != null) 'book_name': bookName,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (verseEnd != null) 'verse_end': verseEnd,
    });
  }

  TopicReferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<int>? entryId,
    Value<String>? bookName,
    Value<int>? chapter,
    Value<int?>? verse,
    Value<int?>? verseEnd,
  }) {
    return TopicReferencesCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      entryId: entryId ?? this.entryId,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      verseEnd: verseEnd ?? this.verseEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (verseEnd.present) {
      map['verse_end'] = Variable<int>(verseEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicReferencesCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('entryId: $entryId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('verseEnd: $verseEnd')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, lat, lng];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<Place> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Place(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class Place extends DataClass implements Insertable<Place> {
  final int id;
  final String name;
  final double lat;
  final double lng;
  const Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: Value(id),
      name: Value(name),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory Place.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  Place copyWith({int? id, String? name, double? lat, double? lng}) => Place(
    id: id ?? this.id,
    name: name ?? this.name,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Place copyWithCompanion(PlacesCompanion data) {
    return Place(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Place &&
          other.id == this.id &&
          other.name == this.name &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> lat;
  final Value<double> lng;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double lat,
    required double lng,
  }) : name = Value(name),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<Place> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  PlacesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? lat,
    Value<double>? lng,
  }) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $PlaceVersesTable extends PlaceVerses
    with TableInfo<$PlaceVersesTable, PlaceVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceVersesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES places (id)',
    ),
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [id, placeId, bookName, chapter, verse];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_verses';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceVerse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceVerse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_id'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
    );
  }

  @override
  $PlaceVersesTable createAlias(String alias) {
    return $PlaceVersesTable(attachedDatabase, alias);
  }
}

class PlaceVerse extends DataClass implements Insertable<PlaceVerse> {
  final int id;
  final int placeId;
  final String bookName;
  final int chapter;
  final int verse;
  const PlaceVerse({
    required this.id,
    required this.placeId,
    required this.bookName,
    required this.chapter,
    required this.verse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['book_name'] = Variable<String>(bookName);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    return map;
  }

  PlaceVersesCompanion toCompanion(bool nullToAbsent) {
    return PlaceVersesCompanion(
      id: Value(id),
      placeId: Value(placeId),
      bookName: Value(bookName),
      chapter: Value(chapter),
      verse: Value(verse),
    );
  }

  factory PlaceVerse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceVerse(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'bookName': serializer.toJson<String>(bookName),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
    };
  }

  PlaceVerse copyWith({
    int? id,
    int? placeId,
    String? bookName,
    int? chapter,
    int? verse,
  }) => PlaceVerse(
    id: id ?? this.id,
    placeId: placeId ?? this.placeId,
    bookName: bookName ?? this.bookName,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
  );
  PlaceVerse copyWithCompanion(PlaceVersesCompanion data) {
    return PlaceVerse(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceVerse(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, bookName, chapter, verse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceVerse &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.bookName == this.bookName &&
          other.chapter == this.chapter &&
          other.verse == this.verse);
}

class PlaceVersesCompanion extends UpdateCompanion<PlaceVerse> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> bookName;
  final Value<int> chapter;
  final Value<int> verse;
  const PlaceVersesCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
  });
  PlaceVersesCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String bookName,
    required int chapter,
    required int verse,
  }) : placeId = Value(placeId),
       bookName = Value(bookName),
       chapter = Value(chapter),
       verse = Value(verse);
  static Insertable<PlaceVerse> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? bookName,
    Expression<int>? chapter,
    Expression<int>? verse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (bookName != null) 'book_name': bookName,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
    });
  }

  PlaceVersesCompanion copyWith({
    Value<int>? id,
    Value<int>? placeId,
    Value<String>? bookName,
    Value<int>? chapter,
    Value<int>? verse,
  }) {
    return PlaceVersesCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceVersesCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }
}

class $BiblePeopleTable extends BiblePeople
    with TableInfo<$BiblePeopleTable, BiblePerson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BiblePeopleTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
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
  static const VerificationMeta _displayTitleMeta = const VerificationMeta(
    'displayTitle',
  );
  @override
  late final GeneratedColumn<String> displayTitle = GeneratedColumn<String>(
    'display_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alsoCalledMeta = const VerificationMeta(
    'alsoCalled',
  );
  @override
  late final GeneratedColumn<String> alsoCalled = GeneratedColumn<String>(
    'also_called',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
    'birth_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deathYearMeta = const VerificationMeta(
    'deathYear',
  );
  @override
  late final GeneratedColumn<int> deathYear = GeneratedColumn<int>(
    'death_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minYearMeta = const VerificationMeta(
    'minYear',
  );
  @override
  late final GeneratedColumn<int> minYear = GeneratedColumn<int>(
    'min_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxYearMeta = const VerificationMeta(
    'maxYear',
  );
  @override
  late final GeneratedColumn<int> maxYear = GeneratedColumn<int>(
    'max_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatherIdMeta = const VerificationMeta(
    'fatherId',
  );
  @override
  late final GeneratedColumn<int> fatherId = GeneratedColumn<int>(
    'father_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motherIdMeta = const VerificationMeta(
    'motherId',
  );
  @override
  late final GeneratedColumn<int> motherId = GeneratedColumn<int>(
    'mother_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verseCountMeta = const VerificationMeta(
    'verseCount',
  );
  @override
  late final GeneratedColumn<int> verseCount = GeneratedColumn<int>(
    'verse_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    name,
    displayTitle,
    gender,
    alsoCalled,
    birthYear,
    deathYear,
    minYear,
    maxYear,
    fatherId,
    motherId,
    bio,
    verseCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_people';
  @override
  VerificationContext validateIntegrity(
    Insertable<BiblePerson> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('display_title')) {
      context.handle(
        _displayTitleMeta,
        displayTitle.isAcceptableOrUnknown(
          data['display_title']!,
          _displayTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayTitleMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('also_called')) {
      context.handle(
        _alsoCalledMeta,
        alsoCalled.isAcceptableOrUnknown(data['also_called']!, _alsoCalledMeta),
      );
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    }
    if (data.containsKey('death_year')) {
      context.handle(
        _deathYearMeta,
        deathYear.isAcceptableOrUnknown(data['death_year']!, _deathYearMeta),
      );
    }
    if (data.containsKey('min_year')) {
      context.handle(
        _minYearMeta,
        minYear.isAcceptableOrUnknown(data['min_year']!, _minYearMeta),
      );
    }
    if (data.containsKey('max_year')) {
      context.handle(
        _maxYearMeta,
        maxYear.isAcceptableOrUnknown(data['max_year']!, _maxYearMeta),
      );
    }
    if (data.containsKey('father_id')) {
      context.handle(
        _fatherIdMeta,
        fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta),
      );
    }
    if (data.containsKey('mother_id')) {
      context.handle(
        _motherIdMeta,
        motherId.isAcceptableOrUnknown(data['mother_id']!, _motherIdMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('verse_count')) {
      context.handle(
        _verseCountMeta,
        verseCount.isAcceptableOrUnknown(data['verse_count']!, _verseCountMeta),
      );
    } else if (isInserting) {
      context.missing(_verseCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BiblePerson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BiblePerson(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      displayTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      alsoCalled: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}also_called'],
      ),
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_year'],
      ),
      deathYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}death_year'],
      ),
      minYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_year'],
      ),
      maxYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_year'],
      ),
      fatherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}father_id'],
      ),
      motherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mother_id'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      verseCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse_count'],
      )!,
    );
  }

  @override
  $BiblePeopleTable createAlias(String alias) {
    return $BiblePeopleTable(attachedDatabase, alias);
  }
}

class BiblePerson extends DataClass implements Insertable<BiblePerson> {
  final int id;
  final String slug;
  final String name;

  /// Name plus a disambiguator where several people share it,
  /// e.g. "Abiel (Arbathite)".
  final String displayTitle;
  final String? gender;

  /// Other names this person goes by, comma-joined ("Ner, Jehiel").
  final String? alsoCalled;
  final int? birthYear;
  final int? deathYear;
  final int? minYear;
  final int? maxYear;
  final int? fatherId;
  final int? motherId;

  /// Easton's Bible Dictionary entry for this person (plain text), when one
  /// exists.
  final String? bio;
  final int verseCount;
  const BiblePerson({
    required this.id,
    required this.slug,
    required this.name,
    required this.displayTitle,
    this.gender,
    this.alsoCalled,
    this.birthYear,
    this.deathYear,
    this.minYear,
    this.maxYear,
    this.fatherId,
    this.motherId,
    this.bio,
    required this.verseCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['display_title'] = Variable<String>(displayTitle);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || alsoCalled != null) {
      map['also_called'] = Variable<String>(alsoCalled);
    }
    if (!nullToAbsent || birthYear != null) {
      map['birth_year'] = Variable<int>(birthYear);
    }
    if (!nullToAbsent || deathYear != null) {
      map['death_year'] = Variable<int>(deathYear);
    }
    if (!nullToAbsent || minYear != null) {
      map['min_year'] = Variable<int>(minYear);
    }
    if (!nullToAbsent || maxYear != null) {
      map['max_year'] = Variable<int>(maxYear);
    }
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<int>(fatherId);
    }
    if (!nullToAbsent || motherId != null) {
      map['mother_id'] = Variable<int>(motherId);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    map['verse_count'] = Variable<int>(verseCount);
    return map;
  }

  BiblePeopleCompanion toCompanion(bool nullToAbsent) {
    return BiblePeopleCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      displayTitle: Value(displayTitle),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      alsoCalled: alsoCalled == null && nullToAbsent
          ? const Value.absent()
          : Value(alsoCalled),
      birthYear: birthYear == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYear),
      deathYear: deathYear == null && nullToAbsent
          ? const Value.absent()
          : Value(deathYear),
      minYear: minYear == null && nullToAbsent
          ? const Value.absent()
          : Value(minYear),
      maxYear: maxYear == null && nullToAbsent
          ? const Value.absent()
          : Value(maxYear),
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      motherId: motherId == null && nullToAbsent
          ? const Value.absent()
          : Value(motherId),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      verseCount: Value(verseCount),
    );
  }

  factory BiblePerson.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BiblePerson(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      displayTitle: serializer.fromJson<String>(json['displayTitle']),
      gender: serializer.fromJson<String?>(json['gender']),
      alsoCalled: serializer.fromJson<String?>(json['alsoCalled']),
      birthYear: serializer.fromJson<int?>(json['birthYear']),
      deathYear: serializer.fromJson<int?>(json['deathYear']),
      minYear: serializer.fromJson<int?>(json['minYear']),
      maxYear: serializer.fromJson<int?>(json['maxYear']),
      fatherId: serializer.fromJson<int?>(json['fatherId']),
      motherId: serializer.fromJson<int?>(json['motherId']),
      bio: serializer.fromJson<String?>(json['bio']),
      verseCount: serializer.fromJson<int>(json['verseCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'displayTitle': serializer.toJson<String>(displayTitle),
      'gender': serializer.toJson<String?>(gender),
      'alsoCalled': serializer.toJson<String?>(alsoCalled),
      'birthYear': serializer.toJson<int?>(birthYear),
      'deathYear': serializer.toJson<int?>(deathYear),
      'minYear': serializer.toJson<int?>(minYear),
      'maxYear': serializer.toJson<int?>(maxYear),
      'fatherId': serializer.toJson<int?>(fatherId),
      'motherId': serializer.toJson<int?>(motherId),
      'bio': serializer.toJson<String?>(bio),
      'verseCount': serializer.toJson<int>(verseCount),
    };
  }

  BiblePerson copyWith({
    int? id,
    String? slug,
    String? name,
    String? displayTitle,
    Value<String?> gender = const Value.absent(),
    Value<String?> alsoCalled = const Value.absent(),
    Value<int?> birthYear = const Value.absent(),
    Value<int?> deathYear = const Value.absent(),
    Value<int?> minYear = const Value.absent(),
    Value<int?> maxYear = const Value.absent(),
    Value<int?> fatherId = const Value.absent(),
    Value<int?> motherId = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    int? verseCount,
  }) => BiblePerson(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    displayTitle: displayTitle ?? this.displayTitle,
    gender: gender.present ? gender.value : this.gender,
    alsoCalled: alsoCalled.present ? alsoCalled.value : this.alsoCalled,
    birthYear: birthYear.present ? birthYear.value : this.birthYear,
    deathYear: deathYear.present ? deathYear.value : this.deathYear,
    minYear: minYear.present ? minYear.value : this.minYear,
    maxYear: maxYear.present ? maxYear.value : this.maxYear,
    fatherId: fatherId.present ? fatherId.value : this.fatherId,
    motherId: motherId.present ? motherId.value : this.motherId,
    bio: bio.present ? bio.value : this.bio,
    verseCount: verseCount ?? this.verseCount,
  );
  BiblePerson copyWithCompanion(BiblePeopleCompanion data) {
    return BiblePerson(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      displayTitle: data.displayTitle.present
          ? data.displayTitle.value
          : this.displayTitle,
      gender: data.gender.present ? data.gender.value : this.gender,
      alsoCalled: data.alsoCalled.present
          ? data.alsoCalled.value
          : this.alsoCalled,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      deathYear: data.deathYear.present ? data.deathYear.value : this.deathYear,
      minYear: data.minYear.present ? data.minYear.value : this.minYear,
      maxYear: data.maxYear.present ? data.maxYear.value : this.maxYear,
      fatherId: data.fatherId.present ? data.fatherId.value : this.fatherId,
      motherId: data.motherId.present ? data.motherId.value : this.motherId,
      bio: data.bio.present ? data.bio.value : this.bio,
      verseCount: data.verseCount.present
          ? data.verseCount.value
          : this.verseCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BiblePerson(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('gender: $gender, ')
          ..write('alsoCalled: $alsoCalled, ')
          ..write('birthYear: $birthYear, ')
          ..write('deathYear: $deathYear, ')
          ..write('minYear: $minYear, ')
          ..write('maxYear: $maxYear, ')
          ..write('fatherId: $fatherId, ')
          ..write('motherId: $motherId, ')
          ..write('bio: $bio, ')
          ..write('verseCount: $verseCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    name,
    displayTitle,
    gender,
    alsoCalled,
    birthYear,
    deathYear,
    minYear,
    maxYear,
    fatherId,
    motherId,
    bio,
    verseCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BiblePerson &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.displayTitle == this.displayTitle &&
          other.gender == this.gender &&
          other.alsoCalled == this.alsoCalled &&
          other.birthYear == this.birthYear &&
          other.deathYear == this.deathYear &&
          other.minYear == this.minYear &&
          other.maxYear == this.maxYear &&
          other.fatherId == this.fatherId &&
          other.motherId == this.motherId &&
          other.bio == this.bio &&
          other.verseCount == this.verseCount);
}

class BiblePeopleCompanion extends UpdateCompanion<BiblePerson> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<String> displayTitle;
  final Value<String?> gender;
  final Value<String?> alsoCalled;
  final Value<int?> birthYear;
  final Value<int?> deathYear;
  final Value<int?> minYear;
  final Value<int?> maxYear;
  final Value<int?> fatherId;
  final Value<int?> motherId;
  final Value<String?> bio;
  final Value<int> verseCount;
  const BiblePeopleCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.displayTitle = const Value.absent(),
    this.gender = const Value.absent(),
    this.alsoCalled = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.deathYear = const Value.absent(),
    this.minYear = const Value.absent(),
    this.maxYear = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.motherId = const Value.absent(),
    this.bio = const Value.absent(),
    this.verseCount = const Value.absent(),
  });
  BiblePeopleCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    required String displayTitle,
    this.gender = const Value.absent(),
    this.alsoCalled = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.deathYear = const Value.absent(),
    this.minYear = const Value.absent(),
    this.maxYear = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.motherId = const Value.absent(),
    this.bio = const Value.absent(),
    required int verseCount,
  }) : slug = Value(slug),
       name = Value(name),
       displayTitle = Value(displayTitle),
       verseCount = Value(verseCount);
  static Insertable<BiblePerson> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? displayTitle,
    Expression<String>? gender,
    Expression<String>? alsoCalled,
    Expression<int>? birthYear,
    Expression<int>? deathYear,
    Expression<int>? minYear,
    Expression<int>? maxYear,
    Expression<int>? fatherId,
    Expression<int>? motherId,
    Expression<String>? bio,
    Expression<int>? verseCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (displayTitle != null) 'display_title': displayTitle,
      if (gender != null) 'gender': gender,
      if (alsoCalled != null) 'also_called': alsoCalled,
      if (birthYear != null) 'birth_year': birthYear,
      if (deathYear != null) 'death_year': deathYear,
      if (minYear != null) 'min_year': minYear,
      if (maxYear != null) 'max_year': maxYear,
      if (fatherId != null) 'father_id': fatherId,
      if (motherId != null) 'mother_id': motherId,
      if (bio != null) 'bio': bio,
      if (verseCount != null) 'verse_count': verseCount,
    });
  }

  BiblePeopleCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<String>? displayTitle,
    Value<String?>? gender,
    Value<String?>? alsoCalled,
    Value<int?>? birthYear,
    Value<int?>? deathYear,
    Value<int?>? minYear,
    Value<int?>? maxYear,
    Value<int?>? fatherId,
    Value<int?>? motherId,
    Value<String?>? bio,
    Value<int>? verseCount,
  }) {
    return BiblePeopleCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      displayTitle: displayTitle ?? this.displayTitle,
      gender: gender ?? this.gender,
      alsoCalled: alsoCalled ?? this.alsoCalled,
      birthYear: birthYear ?? this.birthYear,
      deathYear: deathYear ?? this.deathYear,
      minYear: minYear ?? this.minYear,
      maxYear: maxYear ?? this.maxYear,
      fatherId: fatherId ?? this.fatherId,
      motherId: motherId ?? this.motherId,
      bio: bio ?? this.bio,
      verseCount: verseCount ?? this.verseCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (displayTitle.present) {
      map['display_title'] = Variable<String>(displayTitle.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (alsoCalled.present) {
      map['also_called'] = Variable<String>(alsoCalled.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (deathYear.present) {
      map['death_year'] = Variable<int>(deathYear.value);
    }
    if (minYear.present) {
      map['min_year'] = Variable<int>(minYear.value);
    }
    if (maxYear.present) {
      map['max_year'] = Variable<int>(maxYear.value);
    }
    if (fatherId.present) {
      map['father_id'] = Variable<int>(fatherId.value);
    }
    if (motherId.present) {
      map['mother_id'] = Variable<int>(motherId.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (verseCount.present) {
      map['verse_count'] = Variable<int>(verseCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BiblePeopleCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('gender: $gender, ')
          ..write('alsoCalled: $alsoCalled, ')
          ..write('birthYear: $birthYear, ')
          ..write('deathYear: $deathYear, ')
          ..write('minYear: $minYear, ')
          ..write('maxYear: $maxYear, ')
          ..write('fatherId: $fatherId, ')
          ..write('motherId: $motherId, ')
          ..write('bio: $bio, ')
          ..write('verseCount: $verseCount')
          ..write(')'))
        .toString();
  }
}

class $PersonPartnersTable extends PersonPartners
    with TableInfo<$PersonPartnersTable, PersonPartner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonPartnersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_people (id)',
    ),
  );
  static const VerificationMeta _partnerIdMeta = const VerificationMeta(
    'partnerId',
  );
  @override
  late final GeneratedColumn<int> partnerId = GeneratedColumn<int>(
    'partner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_people (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, personId, partnerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'person_partners';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonPartner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('partner_id')) {
      context.handle(
        _partnerIdMeta,
        partnerId.isAcceptableOrUnknown(data['partner_id']!, _partnerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partnerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonPartner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonPartner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
      partnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partner_id'],
      )!,
    );
  }

  @override
  $PersonPartnersTable createAlias(String alias) {
    return $PersonPartnersTable(attachedDatabase, alias);
  }
}

class PersonPartner extends DataClass implements Insertable<PersonPartner> {
  final int id;
  final int personId;
  final int partnerId;
  const PersonPartner({
    required this.id,
    required this.personId,
    required this.partnerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['person_id'] = Variable<int>(personId);
    map['partner_id'] = Variable<int>(partnerId);
    return map;
  }

  PersonPartnersCompanion toCompanion(bool nullToAbsent) {
    return PersonPartnersCompanion(
      id: Value(id),
      personId: Value(personId),
      partnerId: Value(partnerId),
    );
  }

  factory PersonPartner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonPartner(
      id: serializer.fromJson<int>(json['id']),
      personId: serializer.fromJson<int>(json['personId']),
      partnerId: serializer.fromJson<int>(json['partnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'personId': serializer.toJson<int>(personId),
      'partnerId': serializer.toJson<int>(partnerId),
    };
  }

  PersonPartner copyWith({int? id, int? personId, int? partnerId}) =>
      PersonPartner(
        id: id ?? this.id,
        personId: personId ?? this.personId,
        partnerId: partnerId ?? this.partnerId,
      );
  PersonPartner copyWithCompanion(PersonPartnersCompanion data) {
    return PersonPartner(
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      partnerId: data.partnerId.present ? data.partnerId.value : this.partnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonPartner(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('partnerId: $partnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, personId, partnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonPartner &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.partnerId == this.partnerId);
}

class PersonPartnersCompanion extends UpdateCompanion<PersonPartner> {
  final Value<int> id;
  final Value<int> personId;
  final Value<int> partnerId;
  const PersonPartnersCompanion({
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.partnerId = const Value.absent(),
  });
  PersonPartnersCompanion.insert({
    this.id = const Value.absent(),
    required int personId,
    required int partnerId,
  }) : personId = Value(personId),
       partnerId = Value(partnerId);
  static Insertable<PersonPartner> custom({
    Expression<int>? id,
    Expression<int>? personId,
    Expression<int>? partnerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (partnerId != null) 'partner_id': partnerId,
    });
  }

  PersonPartnersCompanion copyWith({
    Value<int>? id,
    Value<int>? personId,
    Value<int>? partnerId,
  }) {
    return PersonPartnersCompanion(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      partnerId: partnerId ?? this.partnerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (partnerId.present) {
      map['partner_id'] = Variable<int>(partnerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonPartnersCompanion(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('partnerId: $partnerId')
          ..write(')'))
        .toString();
  }
}

class $PersonVersesTable extends PersonVerses
    with TableInfo<$PersonVersesTable, PersonVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonVersesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_people (id)',
    ),
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    personId,
    bookName,
    chapter,
    verse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'person_verses';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonVerse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonVerse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
    );
  }

  @override
  $PersonVersesTable createAlias(String alias) {
    return $PersonVersesTable(attachedDatabase, alias);
  }
}

class PersonVerse extends DataClass implements Insertable<PersonVerse> {
  final int id;
  final int personId;
  final String bookName;
  final int chapter;
  final int verse;
  const PersonVerse({
    required this.id,
    required this.personId,
    required this.bookName,
    required this.chapter,
    required this.verse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['person_id'] = Variable<int>(personId);
    map['book_name'] = Variable<String>(bookName);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    return map;
  }

  PersonVersesCompanion toCompanion(bool nullToAbsent) {
    return PersonVersesCompanion(
      id: Value(id),
      personId: Value(personId),
      bookName: Value(bookName),
      chapter: Value(chapter),
      verse: Value(verse),
    );
  }

  factory PersonVerse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonVerse(
      id: serializer.fromJson<int>(json['id']),
      personId: serializer.fromJson<int>(json['personId']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'personId': serializer.toJson<int>(personId),
      'bookName': serializer.toJson<String>(bookName),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
    };
  }

  PersonVerse copyWith({
    int? id,
    int? personId,
    String? bookName,
    int? chapter,
    int? verse,
  }) => PersonVerse(
    id: id ?? this.id,
    personId: personId ?? this.personId,
    bookName: bookName ?? this.bookName,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
  );
  PersonVerse copyWithCompanion(PersonVersesCompanion data) {
    return PersonVerse(
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonVerse(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, personId, bookName, chapter, verse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonVerse &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.bookName == this.bookName &&
          other.chapter == this.chapter &&
          other.verse == this.verse);
}

class PersonVersesCompanion extends UpdateCompanion<PersonVerse> {
  final Value<int> id;
  final Value<int> personId;
  final Value<String> bookName;
  final Value<int> chapter;
  final Value<int> verse;
  const PersonVersesCompanion({
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
  });
  PersonVersesCompanion.insert({
    this.id = const Value.absent(),
    required int personId,
    required String bookName,
    required int chapter,
    required int verse,
  }) : personId = Value(personId),
       bookName = Value(bookName),
       chapter = Value(chapter),
       verse = Value(verse);
  static Insertable<PersonVerse> custom({
    Expression<int>? id,
    Expression<int>? personId,
    Expression<String>? bookName,
    Expression<int>? chapter,
    Expression<int>? verse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (bookName != null) 'book_name': bookName,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
    });
  }

  PersonVersesCompanion copyWith({
    Value<int>? id,
    Value<int>? personId,
    Value<String>? bookName,
    Value<int>? chapter,
    Value<int>? verse,
  }) {
    return PersonVersesCompanion(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonVersesCompanion(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }
}

class $PeopleGroupsTable extends PeopleGroups
    with TableInfo<$PeopleGroupsTable, PeopleGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeopleGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'people_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeopleGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeopleGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeopleGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PeopleGroupsTable createAlias(String alias) {
    return $PeopleGroupsTable(attachedDatabase, alias);
  }
}

class PeopleGroup extends DataClass implements Insertable<PeopleGroup> {
  final int id;
  final String name;
  const PeopleGroup({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PeopleGroupsCompanion toCompanion(bool nullToAbsent) {
    return PeopleGroupsCompanion(id: Value(id), name: Value(name));
  }

  factory PeopleGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeopleGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PeopleGroup copyWith({int? id, String? name}) =>
      PeopleGroup(id: id ?? this.id, name: name ?? this.name);
  PeopleGroup copyWithCompanion(PeopleGroupsCompanion data) {
    return PeopleGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeopleGroup(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeopleGroup && other.id == this.id && other.name == this.name);
}

class PeopleGroupsCompanion extends UpdateCompanion<PeopleGroup> {
  final Value<int> id;
  final Value<String> name;
  const PeopleGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PeopleGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<PeopleGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PeopleGroupsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return PeopleGroupsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeopleGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PeopleGroupMembersTable extends PeopleGroupMembers
    with TableInfo<$PeopleGroupMembersTable, PeopleGroupMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeopleGroupMembersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES people_groups (id)',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_people (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, personId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'people_group_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeopleGroupMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeopleGroupMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeopleGroupMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
    );
  }

  @override
  $PeopleGroupMembersTable createAlias(String alias) {
    return $PeopleGroupMembersTable(attachedDatabase, alias);
  }
}

class PeopleGroupMember extends DataClass
    implements Insertable<PeopleGroupMember> {
  final int id;
  final int groupId;
  final int personId;
  const PeopleGroupMember({
    required this.id,
    required this.groupId,
    required this.personId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['person_id'] = Variable<int>(personId);
    return map;
  }

  PeopleGroupMembersCompanion toCompanion(bool nullToAbsent) {
    return PeopleGroupMembersCompanion(
      id: Value(id),
      groupId: Value(groupId),
      personId: Value(personId),
    );
  }

  factory PeopleGroupMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeopleGroupMember(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      personId: serializer.fromJson<int>(json['personId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'personId': serializer.toJson<int>(personId),
    };
  }

  PeopleGroupMember copyWith({int? id, int? groupId, int? personId}) =>
      PeopleGroupMember(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        personId: personId ?? this.personId,
      );
  PeopleGroupMember copyWithCompanion(PeopleGroupMembersCompanion data) {
    return PeopleGroupMember(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      personId: data.personId.present ? data.personId.value : this.personId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeopleGroupMember(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('personId: $personId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, personId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeopleGroupMember &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.personId == this.personId);
}

class PeopleGroupMembersCompanion extends UpdateCompanion<PeopleGroupMember> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<int> personId;
  const PeopleGroupMembersCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.personId = const Value.absent(),
  });
  PeopleGroupMembersCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required int personId,
  }) : groupId = Value(groupId),
       personId = Value(personId);
  static Insertable<PeopleGroupMember> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<int>? personId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (personId != null) 'person_id': personId,
    });
  }

  PeopleGroupMembersCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<int>? personId,
  }) {
    return PeopleGroupMembersCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      personId: personId ?? this.personId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeopleGroupMembersCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('personId: $personId')
          ..write(')'))
        .toString();
  }
}

class $TimelineEventsTable extends TimelineEvents
    with TableInfo<$TimelineEventsTable, TimelineEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimelineEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortKeyMeta = const VerificationMeta(
    'sortKey',
  );
  @override
  late final GeneratedColumn<double> sortKey = GeneratedColumn<double>(
    'sort_key',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startYearMeta = const VerificationMeta(
    'startYear',
  );
  @override
  late final GeneratedColumn<int> startYear = GeneratedColumn<int>(
    'start_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, sortKey, startYear];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timeline_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimelineEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort_key')) {
      context.handle(
        _sortKeyMeta,
        sortKey.isAcceptableOrUnknown(data['sort_key']!, _sortKeyMeta),
      );
    }
    if (data.containsKey('start_year')) {
      context.handle(
        _startYearMeta,
        startYear.isAcceptableOrUnknown(data['start_year']!, _startYearMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimelineEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimelineEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sortKey: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sort_key'],
      ),
      startYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_year'],
      ),
    );
  }

  @override
  $TimelineEventsTable createAlias(String alias) {
    return $TimelineEventsTable(attachedDatabase, alias);
  }
}

class TimelineEvent extends DataClass implements Insertable<TimelineEvent> {
  final int id;
  final String title;

  /// Chronological ordering key from the dataset (roughly the ISO start year
  /// plus a fractional tiebreak).
  final double? sortKey;

  /// ISO start year (negative = BC), where known.
  final int? startYear;
  const TimelineEvent({
    required this.id,
    required this.title,
    this.sortKey,
    this.startYear,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || sortKey != null) {
      map['sort_key'] = Variable<double>(sortKey);
    }
    if (!nullToAbsent || startYear != null) {
      map['start_year'] = Variable<int>(startYear);
    }
    return map;
  }

  TimelineEventsCompanion toCompanion(bool nullToAbsent) {
    return TimelineEventsCompanion(
      id: Value(id),
      title: Value(title),
      sortKey: sortKey == null && nullToAbsent
          ? const Value.absent()
          : Value(sortKey),
      startYear: startYear == null && nullToAbsent
          ? const Value.absent()
          : Value(startYear),
    );
  }

  factory TimelineEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimelineEvent(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      sortKey: serializer.fromJson<double?>(json['sortKey']),
      startYear: serializer.fromJson<int?>(json['startYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'sortKey': serializer.toJson<double?>(sortKey),
      'startYear': serializer.toJson<int?>(startYear),
    };
  }

  TimelineEvent copyWith({
    int? id,
    String? title,
    Value<double?> sortKey = const Value.absent(),
    Value<int?> startYear = const Value.absent(),
  }) => TimelineEvent(
    id: id ?? this.id,
    title: title ?? this.title,
    sortKey: sortKey.present ? sortKey.value : this.sortKey,
    startYear: startYear.present ? startYear.value : this.startYear,
  );
  TimelineEvent copyWithCompanion(TimelineEventsCompanion data) {
    return TimelineEvent(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      sortKey: data.sortKey.present ? data.sortKey.value : this.sortKey,
      startYear: data.startYear.present ? data.startYear.value : this.startYear,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEvent(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sortKey: $sortKey, ')
          ..write('startYear: $startYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, sortKey, startYear);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimelineEvent &&
          other.id == this.id &&
          other.title == this.title &&
          other.sortKey == this.sortKey &&
          other.startYear == this.startYear);
}

class TimelineEventsCompanion extends UpdateCompanion<TimelineEvent> {
  final Value<int> id;
  final Value<String> title;
  final Value<double?> sortKey;
  final Value<int?> startYear;
  const TimelineEventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.sortKey = const Value.absent(),
    this.startYear = const Value.absent(),
  });
  TimelineEventsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.sortKey = const Value.absent(),
    this.startYear = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TimelineEvent> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? sortKey,
    Expression<int>? startYear,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (sortKey != null) 'sort_key': sortKey,
      if (startYear != null) 'start_year': startYear,
    });
  }

  TimelineEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<double?>? sortKey,
    Value<int?>? startYear,
  }) {
    return TimelineEventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      sortKey: sortKey ?? this.sortKey,
      startYear: startYear ?? this.startYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortKey.present) {
      map['sort_key'] = Variable<double>(sortKey.value);
    }
    if (startYear.present) {
      map['start_year'] = Variable<int>(startYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimelineEventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('sortKey: $sortKey, ')
          ..write('startYear: $startYear')
          ..write(')'))
        .toString();
  }
}

class $EventParticipantsTable extends EventParticipants
    with TableInfo<$EventParticipantsTable, EventParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventParticipantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES timeline_events (id)',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_people (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventId, personId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_participants';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventParticipant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventParticipant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
    );
  }

  @override
  $EventParticipantsTable createAlias(String alias) {
    return $EventParticipantsTable(attachedDatabase, alias);
  }
}

class EventParticipant extends DataClass
    implements Insertable<EventParticipant> {
  final int id;
  final int eventId;
  final int personId;
  const EventParticipant({
    required this.id,
    required this.eventId,
    required this.personId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['person_id'] = Variable<int>(personId);
    return map;
  }

  EventParticipantsCompanion toCompanion(bool nullToAbsent) {
    return EventParticipantsCompanion(
      id: Value(id),
      eventId: Value(eventId),
      personId: Value(personId),
    );
  }

  factory EventParticipant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventParticipant(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      personId: serializer.fromJson<int>(json['personId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'personId': serializer.toJson<int>(personId),
    };
  }

  EventParticipant copyWith({int? id, int? eventId, int? personId}) =>
      EventParticipant(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        personId: personId ?? this.personId,
      );
  EventParticipant copyWithCompanion(EventParticipantsCompanion data) {
    return EventParticipant(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personId: data.personId.present ? data.personId.value : this.personId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventParticipant(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, personId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventParticipant &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.personId == this.personId);
}

class EventParticipantsCompanion extends UpdateCompanion<EventParticipant> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> personId;
  const EventParticipantsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.personId = const Value.absent(),
  });
  EventParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int personId,
  }) : eventId = Value(eventId),
       personId = Value(personId);
  static Insertable<EventParticipant> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? personId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (personId != null) 'person_id': personId,
    });
  }

  EventParticipantsCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<int>? personId,
  }) {
    return EventParticipantsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('personId: $personId')
          ..write(')'))
        .toString();
  }
}

class $EventVersesTable extends EventVerses
    with TableInfo<$EventVersesTable, EventVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventVersesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES timeline_events (id)',
    ),
  );
  static const VerificationMeta _ordMeta = const VerificationMeta('ord');
  @override
  late final GeneratedColumn<int> ord = GeneratedColumn<int>(
    'ord',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookNameMeta = const VerificationMeta(
    'bookName',
  );
  @override
  late final GeneratedColumn<String> bookName = GeneratedColumn<String>(
    'book_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    ord,
    bookName,
    chapter,
    verse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_verses';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventVerse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('ord')) {
      context.handle(
        _ordMeta,
        ord.isAcceptableOrUnknown(data['ord']!, _ordMeta),
      );
    } else if (isInserting) {
      context.missing(_ordMeta);
    }
    if (data.containsKey('book_name')) {
      context.handle(
        _bookNameMeta,
        bookName.isAcceptableOrUnknown(data['book_name']!, _bookNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bookNameMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventVerse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      ord: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ord'],
      )!,
      bookName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_name'],
      )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter'],
      )!,
      verse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verse'],
      )!,
    );
  }

  @override
  $EventVersesTable createAlias(String alias) {
    return $EventVersesTable(attachedDatabase, alias);
  }
}

class EventVerse extends DataClass implements Insertable<EventVerse> {
  final int id;
  final int eventId;

  /// Position within the event's verse list (they're ordered canonically).
  final int ord;
  final String bookName;
  final int chapter;
  final int verse;
  const EventVerse({
    required this.id,
    required this.eventId,
    required this.ord,
    required this.bookName,
    required this.chapter,
    required this.verse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['ord'] = Variable<int>(ord);
    map['book_name'] = Variable<String>(bookName);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    return map;
  }

  EventVersesCompanion toCompanion(bool nullToAbsent) {
    return EventVersesCompanion(
      id: Value(id),
      eventId: Value(eventId),
      ord: Value(ord),
      bookName: Value(bookName),
      chapter: Value(chapter),
      verse: Value(verse),
    );
  }

  factory EventVerse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventVerse(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      ord: serializer.fromJson<int>(json['ord']),
      bookName: serializer.fromJson<String>(json['bookName']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'ord': serializer.toJson<int>(ord),
      'bookName': serializer.toJson<String>(bookName),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
    };
  }

  EventVerse copyWith({
    int? id,
    int? eventId,
    int? ord,
    String? bookName,
    int? chapter,
    int? verse,
  }) => EventVerse(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    ord: ord ?? this.ord,
    bookName: bookName ?? this.bookName,
    chapter: chapter ?? this.chapter,
    verse: verse ?? this.verse,
  );
  EventVerse copyWithCompanion(EventVersesCompanion data) {
    return EventVerse(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      ord: data.ord.present ? data.ord.value : this.ord,
      bookName: data.bookName.present ? data.bookName.value : this.bookName,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventVerse(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('ord: $ord, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, ord, bookName, chapter, verse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventVerse &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.ord == this.ord &&
          other.bookName == this.bookName &&
          other.chapter == this.chapter &&
          other.verse == this.verse);
}

class EventVersesCompanion extends UpdateCompanion<EventVerse> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> ord;
  final Value<String> bookName;
  final Value<int> chapter;
  final Value<int> verse;
  const EventVersesCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.ord = const Value.absent(),
    this.bookName = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
  });
  EventVersesCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int ord,
    required String bookName,
    required int chapter,
    required int verse,
  }) : eventId = Value(eventId),
       ord = Value(ord),
       bookName = Value(bookName),
       chapter = Value(chapter),
       verse = Value(verse);
  static Insertable<EventVerse> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? ord,
    Expression<String>? bookName,
    Expression<int>? chapter,
    Expression<int>? verse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (ord != null) 'ord': ord,
      if (bookName != null) 'book_name': bookName,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
    });
  }

  EventVersesCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<int>? ord,
    Value<String>? bookName,
    Value<int>? chapter,
    Value<int>? verse,
  }) {
    return EventVersesCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      ord: ord ?? this.ord,
      bookName: bookName ?? this.bookName,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (ord.present) {
      map['ord'] = Variable<int>(ord.value);
    }
    if (bookName.present) {
      map['book_name'] = Variable<String>(bookName.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventVersesCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('ord: $ord, ')
          ..write('bookName: $bookName, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse')
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
  late final $CommentariesTable commentaries = $CommentariesTable(this);
  late final $CommentaryEntriesTable commentaryEntries =
      $CommentaryEntriesTable(this);
  late final $DictionariesTable dictionaries = $DictionariesTable(this);
  late final $DictionaryEntriesTable dictionaryEntries =
      $DictionaryEntriesTable(this);
  late final $SubheadingsTable subheadings = $SubheadingsTable(this);
  late final $DevotionalsTable devotionals = $DevotionalsTable(this);
  late final $DevotionalEntriesTable devotionalEntries =
      $DevotionalEntriesTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $TopicEntriesTable topicEntries = $TopicEntriesTable(this);
  late final $TopicReferencesTable topicReferences = $TopicReferencesTable(
    this,
  );
  late final $PlacesTable places = $PlacesTable(this);
  late final $PlaceVersesTable placeVerses = $PlaceVersesTable(this);
  late final $BiblePeopleTable biblePeople = $BiblePeopleTable(this);
  late final $PersonPartnersTable personPartners = $PersonPartnersTable(this);
  late final $PersonVersesTable personVerses = $PersonVersesTable(this);
  late final $PeopleGroupsTable peopleGroups = $PeopleGroupsTable(this);
  late final $PeopleGroupMembersTable peopleGroupMembers =
      $PeopleGroupMembersTable(this);
  late final $TimelineEventsTable timelineEvents = $TimelineEventsTable(this);
  late final $EventParticipantsTable eventParticipants =
      $EventParticipantsTable(this);
  late final $EventVersesTable eventVerses = $EventVersesTable(this);
  late final Index idxTopicRefLocation = Index(
    'idx_topic_ref_location',
    'CREATE INDEX idx_topic_ref_location ON topic_references (book_name, chapter)',
  );
  late final Index idxPlaceVerseLocation = Index(
    'idx_place_verse_location',
    'CREATE INDEX idx_place_verse_location ON place_verses (book_name, chapter)',
  );
  late final Index idxPersonVerseLocation = Index(
    'idx_person_verse_location',
    'CREATE INDEX idx_person_verse_location ON person_verses (book_name, chapter)',
  );
  late final Index idxPersonVersePerson = Index(
    'idx_person_verse_person',
    'CREATE INDEX idx_person_verse_person ON person_verses (person_id)',
  );
  late final Index idxPeopleGroupMemberPerson = Index(
    'idx_people_group_member_person',
    'CREATE INDEX idx_people_group_member_person ON people_group_members (person_id)',
  );
  late final Index idxEventParticipantPerson = Index(
    'idx_event_participant_person',
    'CREATE INDEX idx_event_participant_person ON event_participants (person_id)',
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
    commentaries,
    commentaryEntries,
    dictionaries,
    dictionaryEntries,
    subheadings,
    devotionals,
    devotionalEntries,
    topics,
    topicEntries,
    topicReferences,
    places,
    placeVerses,
    biblePeople,
    personPartners,
    personVerses,
    peopleGroups,
    peopleGroupMembers,
    timelineEvents,
    eventParticipants,
    eventVerses,
    idxTopicRefLocation,
    idxPlaceVerseLocation,
    idxPersonVerseLocation,
    idxPersonVersePerson,
    idxPeopleGroupMemberPerson,
    idxEventParticipantPerson,
  ];
}

typedef $$VersionsTableCreateCompanionBuilder =
    VersionsCompanion Function({
      required String id,
      required String abbreviation,
      required String name,
      Value<String> language,
      Value<String?> about,
      Value<int> rowid,
    });
typedef $$VersionsTableUpdateCompanionBuilder =
    VersionsCompanion Function({
      Value<String> id,
      Value<String> abbreviation,
      Value<String> name,
      Value<String> language,
      Value<String?> about,
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

  static MultiTypedResultKey<$SubheadingsTable, List<Subheading>>
  _subheadingsRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.subheadings,
    aliasName: 'versions__id__subheadings__version_id',
  );

  $$SubheadingsTableProcessedTableManager get subheadingsRefs {
    final manager = $$SubheadingsTableTableManager(
      $_db,
      $_db.subheadings,
    ).filter((f) => f.versionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subheadingsRefsTable($_db));
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

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
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

  Expression<bool> subheadingsRefs(
    Expression<bool> Function($$SubheadingsTableFilterComposer f) f,
  ) {
    final $$SubheadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subheadings,
      getReferencedColumn: (t) => t.versionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubheadingsTableFilterComposer(
            $db: $db,
            $table: $db.subheadings,
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

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
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

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

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

  Expression<T> subheadingsRefs<T extends Object>(
    Expression<T> Function($$SubheadingsTableAnnotationComposer a) f,
  ) {
    final $$SubheadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subheadings,
      getReferencedColumn: (t) => t.versionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubheadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.subheadings,
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
          PrefetchHooks Function({bool booksRefs, bool subheadingsRefs})
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
                Value<String?> about = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VersionsCompanion(
                id: id,
                abbreviation: abbreviation,
                name: name,
                language: language,
                about: about,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String abbreviation,
                required String name,
                Value<String> language = const Value.absent(),
                Value<String?> about = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VersionsCompanion.insert(
                id: id,
                abbreviation: abbreviation,
                name: name,
                language: language,
                about: about,
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
          prefetchHooksCallback:
              ({booksRefs = false, subheadingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (booksRefs) db.books,
                    if (subheadingsRefs) db.subheadings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (booksRefs)
                        await $_getPrefetchedData<
                          Version,
                          $VersionsTable,
                          Book
                        >(
                          currentTable: table,
                          referencedTable: $$VersionsTableReferences
                              ._booksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).booksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.versionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (subheadingsRefs)
                        await $_getPrefetchedData<
                          Version,
                          $VersionsTable,
                          Subheading
                        >(
                          currentTable: table,
                          referencedTable: $$VersionsTableReferences
                              ._subheadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).subheadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.versionId == item.id,
                              ),
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
      PrefetchHooks Function({bool booksRefs, bool subheadingsRefs})
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
      Value<int?> votes,
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
      Value<int?> votes,
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

  ColumnFilters<int> get votes => $composableBuilder(
    column: $table.votes,
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

  ColumnOrderings<int> get votes => $composableBuilder(
    column: $table.votes,
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

  GeneratedColumn<int> get votes =>
      $composableBuilder(column: $table.votes, builder: (column) => column);
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
                Value<int?> votes = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                sourceBookName: sourceBookName,
                sourceChapter: sourceChapter,
                sourceVerse: sourceVerse,
                targetBookName: targetBookName,
                targetChapter: targetChapter,
                targetVerse: targetVerse,
                votes: votes,
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
                Value<int?> votes = const Value.absent(),
              }) => CrossReferencesCompanion.insert(
                id: id,
                sourceBookName: sourceBookName,
                sourceChapter: sourceChapter,
                sourceVerse: sourceVerse,
                targetBookName: targetBookName,
                targetChapter: targetChapter,
                targetVerse: targetVerse,
                votes: votes,
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
typedef $$CommentariesTableCreateCompanionBuilder =
    CommentariesCompanion Function({
      Value<int> id,
      required String abbreviation,
      required String name,
      Value<String?> about,
    });
typedef $$CommentariesTableUpdateCompanionBuilder =
    CommentariesCompanion Function({
      Value<int> id,
      Value<String> abbreviation,
      Value<String> name,
      Value<String?> about,
    });

final class $$CommentariesTableReferences
    extends BaseReferences<_$ContentStore, $CommentariesTable, Commentary> {
  $$CommentariesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CommentaryEntriesTable, List<CommentaryEntry>>
  _commentaryEntriesRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.commentaryEntries,
        aliasName: 'commentaries__id__commentary_entries__commentary_id',
      );

  $$CommentaryEntriesTableProcessedTableManager get commentaryEntriesRefs {
    final manager = $$CommentaryEntriesTableTableManager(
      $_db,
      $_db.commentaryEntries,
    ).filter((f) => f.commentaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _commentaryEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CommentariesTableFilterComposer
    extends Composer<_$ContentStore, $CommentariesTable> {
  $$CommentariesTableFilterComposer({
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

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> commentaryEntriesRefs(
    Expression<bool> Function($$CommentaryEntriesTableFilterComposer f) f,
  ) {
    final $$CommentaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.commentaryEntries,
      getReferencedColumn: (t) => t.commentaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommentaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.commentaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CommentariesTableOrderingComposer
    extends Composer<_$ContentStore, $CommentariesTable> {
  $$CommentariesTableOrderingComposer({
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

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommentariesTableAnnotationComposer
    extends Composer<_$ContentStore, $CommentariesTable> {
  $$CommentariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

  Expression<T> commentaryEntriesRefs<T extends Object>(
    Expression<T> Function($$CommentaryEntriesTableAnnotationComposer a) f,
  ) {
    final $$CommentaryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.commentaryEntries,
          getReferencedColumn: (t) => t.commentaryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CommentaryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.commentaryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CommentariesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $CommentariesTable,
          Commentary,
          $$CommentariesTableFilterComposer,
          $$CommentariesTableOrderingComposer,
          $$CommentariesTableAnnotationComposer,
          $$CommentariesTableCreateCompanionBuilder,
          $$CommentariesTableUpdateCompanionBuilder,
          (Commentary, $$CommentariesTableReferences),
          Commentary,
          PrefetchHooks Function({bool commentaryEntriesRefs})
        > {
  $$CommentariesTableTableManager(_$ContentStore db, $CommentariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommentariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommentariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommentariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> abbreviation = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> about = const Value.absent(),
              }) => CommentariesCompanion(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String abbreviation,
                required String name,
                Value<String?> about = const Value.absent(),
              }) => CommentariesCompanion.insert(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CommentariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({commentaryEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (commentaryEntriesRefs) db.commentaryEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (commentaryEntriesRefs)
                    await $_getPrefetchedData<
                      Commentary,
                      $CommentariesTable,
                      CommentaryEntry
                    >(
                      currentTable: table,
                      referencedTable: $$CommentariesTableReferences
                          ._commentaryEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CommentariesTableReferences(
                            db,
                            table,
                            p0,
                          ).commentaryEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.commentaryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CommentariesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $CommentariesTable,
      Commentary,
      $$CommentariesTableFilterComposer,
      $$CommentariesTableOrderingComposer,
      $$CommentariesTableAnnotationComposer,
      $$CommentariesTableCreateCompanionBuilder,
      $$CommentariesTableUpdateCompanionBuilder,
      (Commentary, $$CommentariesTableReferences),
      Commentary,
      PrefetchHooks Function({bool commentaryEntriesRefs})
    >;
typedef $$CommentaryEntriesTableCreateCompanionBuilder =
    CommentaryEntriesCompanion Function({
      Value<int> id,
      required int commentaryId,
      required String bookName,
      Value<int?> chapter,
      Value<int?> verse,
      required String textContent,
    });
typedef $$CommentaryEntriesTableUpdateCompanionBuilder =
    CommentaryEntriesCompanion Function({
      Value<int> id,
      Value<int> commentaryId,
      Value<String> bookName,
      Value<int?> chapter,
      Value<int?> verse,
      Value<String> textContent,
    });

final class $$CommentaryEntriesTableReferences
    extends
        BaseReferences<
          _$ContentStore,
          $CommentaryEntriesTable,
          CommentaryEntry
        > {
  $$CommentaryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CommentariesTable _commentaryIdTable(_$ContentStore db) => db
      .commentaries
      .createAlias('commentary_entries__commentary_id__commentaries__id');

  $$CommentariesTableProcessedTableManager get commentaryId {
    final $_column = $_itemColumn<int>('commentary_id')!;

    final manager = $$CommentariesTableTableManager(
      $_db,
      $_db.commentaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_commentaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CommentaryEntriesTableFilterComposer
    extends Composer<_$ContentStore, $CommentaryEntriesTable> {
  $$CommentaryEntriesTableFilterComposer({
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

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$CommentariesTableFilterComposer get commentaryId {
    final $$CommentariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.commentaryId,
      referencedTable: $db.commentaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommentariesTableFilterComposer(
            $db: $db,
            $table: $db.commentaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommentaryEntriesTableOrderingComposer
    extends Composer<_$ContentStore, $CommentaryEntriesTable> {
  $$CommentaryEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$CommentariesTableOrderingComposer get commentaryId {
    final $$CommentariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.commentaryId,
      referencedTable: $db.commentaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommentariesTableOrderingComposer(
            $db: $db,
            $table: $db.commentaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommentaryEntriesTableAnnotationComposer
    extends Composer<_$ContentStore, $CommentaryEntriesTable> {
  $$CommentaryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  $$CommentariesTableAnnotationComposer get commentaryId {
    final $$CommentariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.commentaryId,
      referencedTable: $db.commentaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommentariesTableAnnotationComposer(
            $db: $db,
            $table: $db.commentaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommentaryEntriesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $CommentaryEntriesTable,
          CommentaryEntry,
          $$CommentaryEntriesTableFilterComposer,
          $$CommentaryEntriesTableOrderingComposer,
          $$CommentaryEntriesTableAnnotationComposer,
          $$CommentaryEntriesTableCreateCompanionBuilder,
          $$CommentaryEntriesTableUpdateCompanionBuilder,
          (CommentaryEntry, $$CommentaryEntriesTableReferences),
          CommentaryEntry,
          PrefetchHooks Function({bool commentaryId})
        > {
  $$CommentaryEntriesTableTableManager(
    _$ContentStore db,
    $CommentaryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommentaryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommentaryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommentaryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> commentaryId = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int?> chapter = const Value.absent(),
                Value<int?> verse = const Value.absent(),
                Value<String> textContent = const Value.absent(),
              }) => CommentaryEntriesCompanion(
                id: id,
                commentaryId: commentaryId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int commentaryId,
                required String bookName,
                Value<int?> chapter = const Value.absent(),
                Value<int?> verse = const Value.absent(),
                required String textContent,
              }) => CommentaryEntriesCompanion.insert(
                id: id,
                commentaryId: commentaryId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
                textContent: textContent,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CommentaryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({commentaryId = false}) {
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
                    if (commentaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.commentaryId,
                                referencedTable:
                                    $$CommentaryEntriesTableReferences
                                        ._commentaryIdTable(db),
                                referencedColumn:
                                    $$CommentaryEntriesTableReferences
                                        ._commentaryIdTable(db)
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

typedef $$CommentaryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $CommentaryEntriesTable,
      CommentaryEntry,
      $$CommentaryEntriesTableFilterComposer,
      $$CommentaryEntriesTableOrderingComposer,
      $$CommentaryEntriesTableAnnotationComposer,
      $$CommentaryEntriesTableCreateCompanionBuilder,
      $$CommentaryEntriesTableUpdateCompanionBuilder,
      (CommentaryEntry, $$CommentaryEntriesTableReferences),
      CommentaryEntry,
      PrefetchHooks Function({bool commentaryId})
    >;
typedef $$DictionariesTableCreateCompanionBuilder =
    DictionariesCompanion Function({
      Value<int> id,
      required String abbreviation,
      required String name,
      Value<String?> about,
    });
typedef $$DictionariesTableUpdateCompanionBuilder =
    DictionariesCompanion Function({
      Value<int> id,
      Value<String> abbreviation,
      Value<String> name,
      Value<String?> about,
    });

final class $$DictionariesTableReferences
    extends BaseReferences<_$ContentStore, $DictionariesTable, Dictionary> {
  $$DictionariesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DictionaryEntriesTable, List<DictionaryEntry>>
  _dictionaryEntriesRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.dictionaryEntries,
        aliasName: 'dictionaries__id__dictionary_entries__dictionary_id',
      );

  $$DictionaryEntriesTableProcessedTableManager get dictionaryEntriesRefs {
    final manager = $$DictionaryEntriesTableTableManager(
      $_db,
      $_db.dictionaryEntries,
    ).filter((f) => f.dictionaryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _dictionaryEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DictionariesTableFilterComposer
    extends Composer<_$ContentStore, $DictionariesTable> {
  $$DictionariesTableFilterComposer({
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

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dictionaryEntriesRefs(
    Expression<bool> Function($$DictionaryEntriesTableFilterComposer f) f,
  ) {
    final $$DictionaryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dictionaryEntries,
      getReferencedColumn: (t) => t.dictionaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionaryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.dictionaryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DictionariesTableOrderingComposer
    extends Composer<_$ContentStore, $DictionariesTable> {
  $$DictionariesTableOrderingComposer({
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

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DictionariesTableAnnotationComposer
    extends Composer<_$ContentStore, $DictionariesTable> {
  $$DictionariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

  Expression<T> dictionaryEntriesRefs<T extends Object>(
    Expression<T> Function($$DictionaryEntriesTableAnnotationComposer a) f,
  ) {
    final $$DictionaryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.dictionaryEntries,
          getReferencedColumn: (t) => t.dictionaryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DictionaryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.dictionaryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DictionariesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $DictionariesTable,
          Dictionary,
          $$DictionariesTableFilterComposer,
          $$DictionariesTableOrderingComposer,
          $$DictionariesTableAnnotationComposer,
          $$DictionariesTableCreateCompanionBuilder,
          $$DictionariesTableUpdateCompanionBuilder,
          (Dictionary, $$DictionariesTableReferences),
          Dictionary,
          PrefetchHooks Function({bool dictionaryEntriesRefs})
        > {
  $$DictionariesTableTableManager(_$ContentStore db, $DictionariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictionariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictionariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictionariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> abbreviation = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> about = const Value.absent(),
              }) => DictionariesCompanion(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String abbreviation,
                required String name,
                Value<String?> about = const Value.absent(),
              }) => DictionariesCompanion.insert(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DictionariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dictionaryEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dictionaryEntriesRefs) db.dictionaryEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dictionaryEntriesRefs)
                    await $_getPrefetchedData<
                      Dictionary,
                      $DictionariesTable,
                      DictionaryEntry
                    >(
                      currentTable: table,
                      referencedTable: $$DictionariesTableReferences
                          ._dictionaryEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DictionariesTableReferences(
                            db,
                            table,
                            p0,
                          ).dictionaryEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.dictionaryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DictionariesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $DictionariesTable,
      Dictionary,
      $$DictionariesTableFilterComposer,
      $$DictionariesTableOrderingComposer,
      $$DictionariesTableAnnotationComposer,
      $$DictionariesTableCreateCompanionBuilder,
      $$DictionariesTableUpdateCompanionBuilder,
      (Dictionary, $$DictionariesTableReferences),
      Dictionary,
      PrefetchHooks Function({bool dictionaryEntriesRefs})
    >;
typedef $$DictionaryEntriesTableCreateCompanionBuilder =
    DictionaryEntriesCompanion Function({
      Value<int> id,
      required int dictionaryId,
      required String word,
      required String definition,
    });
typedef $$DictionaryEntriesTableUpdateCompanionBuilder =
    DictionaryEntriesCompanion Function({
      Value<int> id,
      Value<int> dictionaryId,
      Value<String> word,
      Value<String> definition,
    });

final class $$DictionaryEntriesTableReferences
    extends
        BaseReferences<
          _$ContentStore,
          $DictionaryEntriesTable,
          DictionaryEntry
        > {
  $$DictionaryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DictionariesTable _dictionaryIdTable(_$ContentStore db) => db
      .dictionaries
      .createAlias('dictionary_entries__dictionary_id__dictionaries__id');

  $$DictionariesTableProcessedTableManager get dictionaryId {
    final $_column = $_itemColumn<int>('dictionary_id')!;

    final manager = $$DictionariesTableTableManager(
      $_db,
      $_db.dictionaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dictionaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DictionaryEntriesTableFilterComposer
    extends Composer<_$ContentStore, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableFilterComposer({
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

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnFilters(column),
  );

  $$DictionariesTableFilterComposer get dictionaryId {
    final $$DictionariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dictionaryId,
      referencedTable: $db.dictionaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionariesTableFilterComposer(
            $db: $db,
            $table: $db.dictionaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DictionaryEntriesTableOrderingComposer
    extends Composer<_$ContentStore, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  $$DictionariesTableOrderingComposer get dictionaryId {
    final $$DictionariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dictionaryId,
      referencedTable: $db.dictionaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionariesTableOrderingComposer(
            $db: $db,
            $table: $db.dictionaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DictionaryEntriesTableAnnotationComposer
    extends Composer<_$ContentStore, $DictionaryEntriesTable> {
  $$DictionaryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  $$DictionariesTableAnnotationComposer get dictionaryId {
    final $$DictionariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dictionaryId,
      referencedTable: $db.dictionaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DictionariesTableAnnotationComposer(
            $db: $db,
            $table: $db.dictionaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DictionaryEntriesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $DictionaryEntriesTable,
          DictionaryEntry,
          $$DictionaryEntriesTableFilterComposer,
          $$DictionaryEntriesTableOrderingComposer,
          $$DictionaryEntriesTableAnnotationComposer,
          $$DictionaryEntriesTableCreateCompanionBuilder,
          $$DictionaryEntriesTableUpdateCompanionBuilder,
          (DictionaryEntry, $$DictionaryEntriesTableReferences),
          DictionaryEntry,
          PrefetchHooks Function({bool dictionaryId})
        > {
  $$DictionaryEntriesTableTableManager(
    _$ContentStore db,
    $DictionaryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictionaryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictionaryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictionaryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dictionaryId = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> definition = const Value.absent(),
              }) => DictionaryEntriesCompanion(
                id: id,
                dictionaryId: dictionaryId,
                word: word,
                definition: definition,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dictionaryId,
                required String word,
                required String definition,
              }) => DictionaryEntriesCompanion.insert(
                id: id,
                dictionaryId: dictionaryId,
                word: word,
                definition: definition,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DictionaryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dictionaryId = false}) {
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
                    if (dictionaryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dictionaryId,
                                referencedTable:
                                    $$DictionaryEntriesTableReferences
                                        ._dictionaryIdTable(db),
                                referencedColumn:
                                    $$DictionaryEntriesTableReferences
                                        ._dictionaryIdTable(db)
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

typedef $$DictionaryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $DictionaryEntriesTable,
      DictionaryEntry,
      $$DictionaryEntriesTableFilterComposer,
      $$DictionaryEntriesTableOrderingComposer,
      $$DictionaryEntriesTableAnnotationComposer,
      $$DictionaryEntriesTableCreateCompanionBuilder,
      $$DictionaryEntriesTableUpdateCompanionBuilder,
      (DictionaryEntry, $$DictionaryEntriesTableReferences),
      DictionaryEntry,
      PrefetchHooks Function({bool dictionaryId})
    >;
typedef $$SubheadingsTableCreateCompanionBuilder =
    SubheadingsCompanion Function({
      Value<int> id,
      required String versionId,
      required int bookOrder,
      required int chapter,
      required int verse,
      Value<int> orderIfSeveral,
      required String textContent,
      Value<String?> about,
    });
typedef $$SubheadingsTableUpdateCompanionBuilder =
    SubheadingsCompanion Function({
      Value<int> id,
      Value<String> versionId,
      Value<int> bookOrder,
      Value<int> chapter,
      Value<int> verse,
      Value<int> orderIfSeveral,
      Value<String> textContent,
      Value<String?> about,
    });

final class $$SubheadingsTableReferences
    extends BaseReferences<_$ContentStore, $SubheadingsTable, Subheading> {
  $$SubheadingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VersionsTable _versionIdTable(_$ContentStore db) =>
      db.versions.createAlias('subheadings__version_id__versions__id');

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
}

class $$SubheadingsTableFilterComposer
    extends Composer<_$ContentStore, $SubheadingsTable> {
  $$SubheadingsTableFilterComposer({
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

  ColumnFilters<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
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

  ColumnFilters<int> get orderIfSeveral => $composableBuilder(
    column: $table.orderIfSeveral,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
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
}

class $$SubheadingsTableOrderingComposer
    extends Composer<_$ContentStore, $SubheadingsTable> {
  $$SubheadingsTableOrderingComposer({
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

  ColumnOrderings<int> get bookOrder => $composableBuilder(
    column: $table.bookOrder,
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

  ColumnOrderings<int> get orderIfSeveral => $composableBuilder(
    column: $table.orderIfSeveral,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
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

class $$SubheadingsTableAnnotationComposer
    extends Composer<_$ContentStore, $SubheadingsTable> {
  $$SubheadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookOrder =>
      $composableBuilder(column: $table.bookOrder, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<int> get orderIfSeveral => $composableBuilder(
    column: $table.orderIfSeveral,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

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
}

class $$SubheadingsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $SubheadingsTable,
          Subheading,
          $$SubheadingsTableFilterComposer,
          $$SubheadingsTableOrderingComposer,
          $$SubheadingsTableAnnotationComposer,
          $$SubheadingsTableCreateCompanionBuilder,
          $$SubheadingsTableUpdateCompanionBuilder,
          (Subheading, $$SubheadingsTableReferences),
          Subheading,
          PrefetchHooks Function({bool versionId})
        > {
  $$SubheadingsTableTableManager(_$ContentStore db, $SubheadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubheadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubheadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubheadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> versionId = const Value.absent(),
                Value<int> bookOrder = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
                Value<int> orderIfSeveral = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String?> about = const Value.absent(),
              }) => SubheadingsCompanion(
                id: id,
                versionId: versionId,
                bookOrder: bookOrder,
                chapter: chapter,
                verse: verse,
                orderIfSeveral: orderIfSeveral,
                textContent: textContent,
                about: about,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String versionId,
                required int bookOrder,
                required int chapter,
                required int verse,
                Value<int> orderIfSeveral = const Value.absent(),
                required String textContent,
                Value<String?> about = const Value.absent(),
              }) => SubheadingsCompanion.insert(
                id: id,
                versionId: versionId,
                bookOrder: bookOrder,
                chapter: chapter,
                verse: verse,
                orderIfSeveral: orderIfSeveral,
                textContent: textContent,
                about: about,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubheadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({versionId = false}) {
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
                    if (versionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.versionId,
                                referencedTable: $$SubheadingsTableReferences
                                    ._versionIdTable(db),
                                referencedColumn: $$SubheadingsTableReferences
                                    ._versionIdTable(db)
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

typedef $$SubheadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $SubheadingsTable,
      Subheading,
      $$SubheadingsTableFilterComposer,
      $$SubheadingsTableOrderingComposer,
      $$SubheadingsTableAnnotationComposer,
      $$SubheadingsTableCreateCompanionBuilder,
      $$SubheadingsTableUpdateCompanionBuilder,
      (Subheading, $$SubheadingsTableReferences),
      Subheading,
      PrefetchHooks Function({bool versionId})
    >;
typedef $$DevotionalsTableCreateCompanionBuilder =
    DevotionalsCompanion Function({
      Value<int> id,
      required String abbreviation,
      required String name,
      Value<String?> about,
    });
typedef $$DevotionalsTableUpdateCompanionBuilder =
    DevotionalsCompanion Function({
      Value<int> id,
      Value<String> abbreviation,
      Value<String> name,
      Value<String?> about,
    });

final class $$DevotionalsTableReferences
    extends BaseReferences<_$ContentStore, $DevotionalsTable, Devotional> {
  $$DevotionalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DevotionalEntriesTable, List<DevotionalEntry>>
  _devotionalEntriesRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.devotionalEntries,
        aliasName: 'devotionals__id__devotional_entries__devotional_id',
      );

  $$DevotionalEntriesTableProcessedTableManager get devotionalEntriesRefs {
    final manager = $$DevotionalEntriesTableTableManager(
      $_db,
      $_db.devotionalEntries,
    ).filter((f) => f.devotionalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _devotionalEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DevotionalsTableFilterComposer
    extends Composer<_$ContentStore, $DevotionalsTable> {
  $$DevotionalsTableFilterComposer({
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

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> devotionalEntriesRefs(
    Expression<bool> Function($$DevotionalEntriesTableFilterComposer f) f,
  ) {
    final $$DevotionalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.devotionalEntries,
      getReferencedColumn: (t) => t.devotionalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevotionalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.devotionalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DevotionalsTableOrderingComposer
    extends Composer<_$ContentStore, $DevotionalsTable> {
  $$DevotionalsTableOrderingComposer({
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

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get about => $composableBuilder(
    column: $table.about,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DevotionalsTableAnnotationComposer
    extends Composer<_$ContentStore, $DevotionalsTable> {
  $$DevotionalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get about =>
      $composableBuilder(column: $table.about, builder: (column) => column);

  Expression<T> devotionalEntriesRefs<T extends Object>(
    Expression<T> Function($$DevotionalEntriesTableAnnotationComposer a) f,
  ) {
    final $$DevotionalEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.devotionalEntries,
          getReferencedColumn: (t) => t.devotionalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DevotionalEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.devotionalEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DevotionalsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $DevotionalsTable,
          Devotional,
          $$DevotionalsTableFilterComposer,
          $$DevotionalsTableOrderingComposer,
          $$DevotionalsTableAnnotationComposer,
          $$DevotionalsTableCreateCompanionBuilder,
          $$DevotionalsTableUpdateCompanionBuilder,
          (Devotional, $$DevotionalsTableReferences),
          Devotional,
          PrefetchHooks Function({bool devotionalEntriesRefs})
        > {
  $$DevotionalsTableTableManager(_$ContentStore db, $DevotionalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevotionalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevotionalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevotionalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> abbreviation = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> about = const Value.absent(),
              }) => DevotionalsCompanion(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String abbreviation,
                required String name,
                Value<String?> about = const Value.absent(),
              }) => DevotionalsCompanion.insert(
                id: id,
                abbreviation: abbreviation,
                name: name,
                about: about,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DevotionalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({devotionalEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (devotionalEntriesRefs) db.devotionalEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (devotionalEntriesRefs)
                    await $_getPrefetchedData<
                      Devotional,
                      $DevotionalsTable,
                      DevotionalEntry
                    >(
                      currentTable: table,
                      referencedTable: $$DevotionalsTableReferences
                          ._devotionalEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DevotionalsTableReferences(
                            db,
                            table,
                            p0,
                          ).devotionalEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.devotionalId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DevotionalsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $DevotionalsTable,
      Devotional,
      $$DevotionalsTableFilterComposer,
      $$DevotionalsTableOrderingComposer,
      $$DevotionalsTableAnnotationComposer,
      $$DevotionalsTableCreateCompanionBuilder,
      $$DevotionalsTableUpdateCompanionBuilder,
      (Devotional, $$DevotionalsTableReferences),
      Devotional,
      PrefetchHooks Function({bool devotionalEntriesRefs})
    >;
typedef $$DevotionalEntriesTableCreateCompanionBuilder =
    DevotionalEntriesCompanion Function({
      Value<int> id,
      required int devotionalId,
      required int day,
      required String textContent,
    });
typedef $$DevotionalEntriesTableUpdateCompanionBuilder =
    DevotionalEntriesCompanion Function({
      Value<int> id,
      Value<int> devotionalId,
      Value<int> day,
      Value<String> textContent,
    });

final class $$DevotionalEntriesTableReferences
    extends
        BaseReferences<
          _$ContentStore,
          $DevotionalEntriesTable,
          DevotionalEntry
        > {
  $$DevotionalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DevotionalsTable _devotionalIdTable(_$ContentStore db) => db
      .devotionals
      .createAlias('devotional_entries__devotional_id__devotionals__id');

  $$DevotionalsTableProcessedTableManager get devotionalId {
    final $_column = $_itemColumn<int>('devotional_id')!;

    final manager = $$DevotionalsTableTableManager(
      $_db,
      $_db.devotionals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_devotionalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DevotionalEntriesTableFilterComposer
    extends Composer<_$ContentStore, $DevotionalEntriesTable> {
  $$DevotionalEntriesTableFilterComposer({
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

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  $$DevotionalsTableFilterComposer get devotionalId {
    final $$DevotionalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.devotionalId,
      referencedTable: $db.devotionals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevotionalsTableFilterComposer(
            $db: $db,
            $table: $db.devotionals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevotionalEntriesTableOrderingComposer
    extends Composer<_$ContentStore, $DevotionalEntriesTable> {
  $$DevotionalEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  $$DevotionalsTableOrderingComposer get devotionalId {
    final $$DevotionalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.devotionalId,
      referencedTable: $db.devotionals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevotionalsTableOrderingComposer(
            $db: $db,
            $table: $db.devotionals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevotionalEntriesTableAnnotationComposer
    extends Composer<_$ContentStore, $DevotionalEntriesTable> {
  $$DevotionalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  $$DevotionalsTableAnnotationComposer get devotionalId {
    final $$DevotionalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.devotionalId,
      referencedTable: $db.devotionals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DevotionalsTableAnnotationComposer(
            $db: $db,
            $table: $db.devotionals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DevotionalEntriesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $DevotionalEntriesTable,
          DevotionalEntry,
          $$DevotionalEntriesTableFilterComposer,
          $$DevotionalEntriesTableOrderingComposer,
          $$DevotionalEntriesTableAnnotationComposer,
          $$DevotionalEntriesTableCreateCompanionBuilder,
          $$DevotionalEntriesTableUpdateCompanionBuilder,
          (DevotionalEntry, $$DevotionalEntriesTableReferences),
          DevotionalEntry,
          PrefetchHooks Function({bool devotionalId})
        > {
  $$DevotionalEntriesTableTableManager(
    _$ContentStore db,
    $DevotionalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevotionalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevotionalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevotionalEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> devotionalId = const Value.absent(),
                Value<int> day = const Value.absent(),
                Value<String> textContent = const Value.absent(),
              }) => DevotionalEntriesCompanion(
                id: id,
                devotionalId: devotionalId,
                day: day,
                textContent: textContent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int devotionalId,
                required int day,
                required String textContent,
              }) => DevotionalEntriesCompanion.insert(
                id: id,
                devotionalId: devotionalId,
                day: day,
                textContent: textContent,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DevotionalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({devotionalId = false}) {
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
                    if (devotionalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.devotionalId,
                                referencedTable:
                                    $$DevotionalEntriesTableReferences
                                        ._devotionalIdTable(db),
                                referencedColumn:
                                    $$DevotionalEntriesTableReferences
                                        ._devotionalIdTable(db)
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

typedef $$DevotionalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $DevotionalEntriesTable,
      DevotionalEntry,
      $$DevotionalEntriesTableFilterComposer,
      $$DevotionalEntriesTableOrderingComposer,
      $$DevotionalEntriesTableAnnotationComposer,
      $$DevotionalEntriesTableCreateCompanionBuilder,
      $$DevotionalEntriesTableUpdateCompanionBuilder,
      (DevotionalEntry, $$DevotionalEntriesTableReferences),
      DevotionalEntry,
      PrefetchHooks Function({bool devotionalId})
    >;
typedef $$TopicsTableCreateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      required String name,
      required String section,
    });
typedef $$TopicsTableUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> section,
    });

final class $$TopicsTableReferences
    extends BaseReferences<_$ContentStore, $TopicsTable, Topic> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TopicEntriesTable, List<TopicEntry>>
  _topicEntriesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.topicEntries,
    aliasName: 'topics__id__topic_entries__topic_id',
  );

  $$TopicEntriesTableProcessedTableManager get topicEntriesRefs {
    final manager = $$TopicEntriesTableTableManager(
      $_db,
      $_db.topicEntries,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TopicReferencesTable, List<TopicReference>>
  _topicReferencesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.topicReferences,
    aliasName: 'topics__id__topic_references__topic_id',
  );

  $$TopicReferencesTableProcessedTableManager get topicReferencesRefs {
    final manager = $$TopicReferencesTableTableManager(
      $_db,
      $_db.topicReferences,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _topicReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$ContentStore, $TopicsTable> {
  $$TopicsTableFilterComposer({
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

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicEntriesRefs(
    Expression<bool> Function($$TopicEntriesTableFilterComposer f) f,
  ) {
    final $$TopicEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicEntries,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicEntriesTableFilterComposer(
            $db: $db,
            $table: $db.topicEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> topicReferencesRefs(
    Expression<bool> Function($$TopicReferencesTableFilterComposer f) f,
  ) {
    final $$TopicReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicReferences,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicReferencesTableFilterComposer(
            $db: $db,
            $table: $db.topicReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$ContentStore, $TopicsTable> {
  $$TopicsTableOrderingComposer({
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

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$ContentStore, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
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

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  Expression<T> topicEntriesRefs<T extends Object>(
    Expression<T> Function($$TopicEntriesTableAnnotationComposer a) f,
  ) {
    final $$TopicEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicEntries,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.topicEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> topicReferencesRefs<T extends Object>(
    Expression<T> Function($$TopicReferencesTableAnnotationComposer a) f,
  ) {
    final $$TopicReferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicReferences,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicReferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.topicReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $TopicsTable,
          Topic,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (Topic, $$TopicsTableReferences),
          Topic,
          PrefetchHooks Function({
            bool topicEntriesRefs,
            bool topicReferencesRefs,
          })
        > {
  $$TopicsTableTableManager(_$ContentStore db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> section = const Value.absent(),
              }) => TopicsCompanion(id: id, name: name, section: section),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String section,
              }) =>
                  TopicsCompanion.insert(id: id, name: name, section: section),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TopicsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({topicEntriesRefs = false, topicReferencesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (topicEntriesRefs) db.topicEntries,
                    if (topicReferencesRefs) db.topicReferences,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (topicEntriesRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          TopicEntry
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._topicEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).topicEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (topicReferencesRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          TopicReference
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._topicReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).topicReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $TopicsTable,
      Topic,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (Topic, $$TopicsTableReferences),
      Topic,
      PrefetchHooks Function({bool topicEntriesRefs, bool topicReferencesRefs})
    >;
typedef $$TopicEntriesTableCreateCompanionBuilder =
    TopicEntriesCompanion Function({
      Value<int> id,
      required int topicId,
      required int ordinal,
      required String description,
      Value<String?> seeAlso,
    });
typedef $$TopicEntriesTableUpdateCompanionBuilder =
    TopicEntriesCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<int> ordinal,
      Value<String> description,
      Value<String?> seeAlso,
    });

final class $$TopicEntriesTableReferences
    extends BaseReferences<_$ContentStore, $TopicEntriesTable, TopicEntry> {
  $$TopicEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TopicsTable _topicIdTable(_$ContentStore db) =>
      db.topics.createAlias('topic_entries__topic_id__topics__id');

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TopicReferencesTable, List<TopicReference>>
  _topicReferencesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.topicReferences,
    aliasName: 'topic_entries__id__topic_references__entry_id',
  );

  $$TopicReferencesTableProcessedTableManager get topicReferencesRefs {
    final manager = $$TopicReferencesTableTableManager(
      $_db,
      $_db.topicReferences,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _topicReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicEntriesTableFilterComposer
    extends Composer<_$ContentStore, $TopicEntriesTable> {
  $$TopicEntriesTableFilterComposer({
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

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seeAlso => $composableBuilder(
    column: $table.seeAlso,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> topicReferencesRefs(
    Expression<bool> Function($$TopicReferencesTableFilterComposer f) f,
  ) {
    final $$TopicReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicReferences,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicReferencesTableFilterComposer(
            $db: $db,
            $table: $db.topicReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicEntriesTableOrderingComposer
    extends Composer<_$ContentStore, $TopicEntriesTable> {
  $$TopicEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seeAlso => $composableBuilder(
    column: $table.seeAlso,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicEntriesTableAnnotationComposer
    extends Composer<_$ContentStore, $TopicEntriesTable> {
  $$TopicEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seeAlso =>
      $composableBuilder(column: $table.seeAlso, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> topicReferencesRefs<T extends Object>(
    Expression<T> Function($$TopicReferencesTableAnnotationComposer a) f,
  ) {
    final $$TopicReferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicReferences,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicReferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.topicReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicEntriesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $TopicEntriesTable,
          TopicEntry,
          $$TopicEntriesTableFilterComposer,
          $$TopicEntriesTableOrderingComposer,
          $$TopicEntriesTableAnnotationComposer,
          $$TopicEntriesTableCreateCompanionBuilder,
          $$TopicEntriesTableUpdateCompanionBuilder,
          (TopicEntry, $$TopicEntriesTableReferences),
          TopicEntry,
          PrefetchHooks Function({bool topicId, bool topicReferencesRefs})
        > {
  $$TopicEntriesTableTableManager(_$ContentStore db, $TopicEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> seeAlso = const Value.absent(),
              }) => TopicEntriesCompanion(
                id: id,
                topicId: topicId,
                ordinal: ordinal,
                description: description,
                seeAlso: seeAlso,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required int ordinal,
                required String description,
                Value<String?> seeAlso = const Value.absent(),
              }) => TopicEntriesCompanion.insert(
                id: id,
                topicId: topicId,
                ordinal: ordinal,
                description: description,
                seeAlso: seeAlso,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TopicEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({topicId = false, topicReferencesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (topicReferencesRefs) db.topicReferences,
                  ],
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
                        if (topicId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.topicId,
                                    referencedTable:
                                        $$TopicEntriesTableReferences
                                            ._topicIdTable(db),
                                    referencedColumn:
                                        $$TopicEntriesTableReferences
                                            ._topicIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (topicReferencesRefs)
                        await $_getPrefetchedData<
                          TopicEntry,
                          $TopicEntriesTable,
                          TopicReference
                        >(
                          currentTable: table,
                          referencedTable: $$TopicEntriesTableReferences
                              ._topicReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).topicReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TopicEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $TopicEntriesTable,
      TopicEntry,
      $$TopicEntriesTableFilterComposer,
      $$TopicEntriesTableOrderingComposer,
      $$TopicEntriesTableAnnotationComposer,
      $$TopicEntriesTableCreateCompanionBuilder,
      $$TopicEntriesTableUpdateCompanionBuilder,
      (TopicEntry, $$TopicEntriesTableReferences),
      TopicEntry,
      PrefetchHooks Function({bool topicId, bool topicReferencesRefs})
    >;
typedef $$TopicReferencesTableCreateCompanionBuilder =
    TopicReferencesCompanion Function({
      Value<int> id,
      required int topicId,
      required int entryId,
      required String bookName,
      required int chapter,
      Value<int?> verse,
      Value<int?> verseEnd,
    });
typedef $$TopicReferencesTableUpdateCompanionBuilder =
    TopicReferencesCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<int> entryId,
      Value<String> bookName,
      Value<int> chapter,
      Value<int?> verse,
      Value<int?> verseEnd,
    });

final class $$TopicReferencesTableReferences
    extends
        BaseReferences<_$ContentStore, $TopicReferencesTable, TopicReference> {
  $$TopicReferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$ContentStore db) =>
      db.topics.createAlias('topic_references__topic_id__topics__id');

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicEntriesTable _entryIdTable(_$ContentStore db) => db.topicEntries
      .createAlias('topic_references__entry_id__topic_entries__id');

  $$TopicEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$TopicEntriesTableTableManager(
      $_db,
      $_db.topicEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TopicReferencesTableFilterComposer
    extends Composer<_$ContentStore, $TopicReferencesTable> {
  $$TopicReferencesTableFilterComposer({
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

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  ColumnFilters<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicEntriesTableFilterComposer get entryId {
    final $$TopicEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.topicEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicEntriesTableFilterComposer(
            $db: $db,
            $table: $db.topicEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicReferencesTableOrderingComposer
    extends Composer<_$ContentStore, $TopicReferencesTable> {
  $$TopicReferencesTableOrderingComposer({
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

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  ColumnOrderings<int> get verseEnd => $composableBuilder(
    column: $table.verseEnd,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicEntriesTableOrderingComposer get entryId {
    final $$TopicEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.topicEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.topicEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicReferencesTableAnnotationComposer
    extends Composer<_$ContentStore, $TopicReferencesTable> {
  $$TopicReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<int> get verseEnd =>
      $composableBuilder(column: $table.verseEnd, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicEntriesTableAnnotationComposer get entryId {
    final $$TopicEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.topicEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.topicEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicReferencesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $TopicReferencesTable,
          TopicReference,
          $$TopicReferencesTableFilterComposer,
          $$TopicReferencesTableOrderingComposer,
          $$TopicReferencesTableAnnotationComposer,
          $$TopicReferencesTableCreateCompanionBuilder,
          $$TopicReferencesTableUpdateCompanionBuilder,
          (TopicReference, $$TopicReferencesTableReferences),
          TopicReference,
          PrefetchHooks Function({bool topicId, bool entryId})
        > {
  $$TopicReferencesTableTableManager(
    _$ContentStore db,
    $TopicReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int?> verse = const Value.absent(),
                Value<int?> verseEnd = const Value.absent(),
              }) => TopicReferencesCompanion(
                id: id,
                topicId: topicId,
                entryId: entryId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
                verseEnd: verseEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required int entryId,
                required String bookName,
                required int chapter,
                Value<int?> verse = const Value.absent(),
                Value<int?> verseEnd = const Value.absent(),
              }) => TopicReferencesCompanion.insert(
                id: id,
                topicId: topicId,
                entryId: entryId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
                verseEnd: verseEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TopicReferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicId = false, entryId = false}) {
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
                    if (topicId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.topicId,
                                referencedTable:
                                    $$TopicReferencesTableReferences
                                        ._topicIdTable(db),
                                referencedColumn:
                                    $$TopicReferencesTableReferences
                                        ._topicIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable:
                                    $$TopicReferencesTableReferences
                                        ._entryIdTable(db),
                                referencedColumn:
                                    $$TopicReferencesTableReferences
                                        ._entryIdTable(db)
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

typedef $$TopicReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $TopicReferencesTable,
      TopicReference,
      $$TopicReferencesTableFilterComposer,
      $$TopicReferencesTableOrderingComposer,
      $$TopicReferencesTableAnnotationComposer,
      $$TopicReferencesTableCreateCompanionBuilder,
      $$TopicReferencesTableUpdateCompanionBuilder,
      (TopicReference, $$TopicReferencesTableReferences),
      TopicReference,
      PrefetchHooks Function({bool topicId, bool entryId})
    >;
typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      required String name,
      required double lat,
      required double lng,
    });
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> lat,
      Value<double> lng,
    });

final class $$PlacesTableReferences
    extends BaseReferences<_$ContentStore, $PlacesTable, Place> {
  $$PlacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaceVersesTable, List<PlaceVerse>>
  _placeVersesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.placeVerses,
    aliasName: 'places__id__place_verses__place_id',
  );

  $$PlaceVersesTableProcessedTableManager get placeVersesRefs {
    final manager = $$PlaceVersesTableTableManager(
      $_db,
      $_db.placeVerses,
    ).filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_placeVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlacesTableFilterComposer
    extends Composer<_$ContentStore, $PlacesTable> {
  $$PlacesTableFilterComposer({
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

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> placeVersesRefs(
    Expression<bool> Function($$PlaceVersesTableFilterComposer f) f,
  ) {
    final $$PlaceVersesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.placeVerses,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaceVersesTableFilterComposer(
            $db: $db,
            $table: $db.placeVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableOrderingComposer
    extends Composer<_$ContentStore, $PlacesTable> {
  $$PlacesTableOrderingComposer({
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

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$ContentStore, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
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

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  Expression<T> placeVersesRefs<T extends Object>(
    Expression<T> Function($$PlaceVersesTableAnnotationComposer a) f,
  ) {
    final $$PlaceVersesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.placeVerses,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaceVersesTableAnnotationComposer(
            $db: $db,
            $table: $db.placeVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PlacesTable,
          Place,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (Place, $$PlacesTableReferences),
          Place,
          PrefetchHooks Function({bool placeVersesRefs})
        > {
  $$PlacesTableTableManager(_$ContentStore db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
              }) => PlacesCompanion(id: id, name: name, lat: lat, lng: lng),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double lat,
                required double lng,
              }) => PlacesCompanion.insert(
                id: id,
                name: name,
                lat: lat,
                lng: lng,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlacesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({placeVersesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (placeVersesRefs) db.placeVerses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (placeVersesRefs)
                    await $_getPrefetchedData<Place, $PlacesTable, PlaceVerse>(
                      currentTable: table,
                      referencedTable: $$PlacesTableReferences
                          ._placeVersesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlacesTableReferences(
                        db,
                        table,
                        p0,
                      ).placeVersesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.placeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PlacesTable,
      Place,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (Place, $$PlacesTableReferences),
      Place,
      PrefetchHooks Function({bool placeVersesRefs})
    >;
typedef $$PlaceVersesTableCreateCompanionBuilder =
    PlaceVersesCompanion Function({
      Value<int> id,
      required int placeId,
      required String bookName,
      required int chapter,
      required int verse,
    });
typedef $$PlaceVersesTableUpdateCompanionBuilder =
    PlaceVersesCompanion Function({
      Value<int> id,
      Value<int> placeId,
      Value<String> bookName,
      Value<int> chapter,
      Value<int> verse,
    });

final class $$PlaceVersesTableReferences
    extends BaseReferences<_$ContentStore, $PlaceVersesTable, PlaceVerse> {
  $$PlaceVersesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTable _placeIdTable(_$ContentStore db) =>
      db.places.createAlias('place_verses__place_id__places__id');

  $$PlacesTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableManager(
      $_db,
      $_db.places,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaceVersesTableFilterComposer
    extends Composer<_$ContentStore, $PlaceVersesTable> {
  $$PlaceVersesTableFilterComposer({
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

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$PlacesTableFilterComposer get placeId {
    final $$PlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableFilterComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaceVersesTableOrderingComposer
    extends Composer<_$ContentStore, $PlaceVersesTable> {
  $$PlaceVersesTableOrderingComposer({
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

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$PlacesTableOrderingComposer get placeId {
    final $$PlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableOrderingComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaceVersesTableAnnotationComposer
    extends Composer<_$ContentStore, $PlaceVersesTable> {
  $$PlaceVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  $$PlacesTableAnnotationComposer get placeId {
    final $$PlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaceVersesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PlaceVersesTable,
          PlaceVerse,
          $$PlaceVersesTableFilterComposer,
          $$PlaceVersesTableOrderingComposer,
          $$PlaceVersesTableAnnotationComposer,
          $$PlaceVersesTableCreateCompanionBuilder,
          $$PlaceVersesTableUpdateCompanionBuilder,
          (PlaceVerse, $$PlaceVersesTableReferences),
          PlaceVerse,
          PrefetchHooks Function({bool placeId})
        > {
  $$PlaceVersesTableTableManager(_$ContentStore db, $PlaceVersesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaceVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaceVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaceVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> placeId = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
              }) => PlaceVersesCompanion(
                id: id,
                placeId: placeId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int placeId,
                required String bookName,
                required int chapter,
                required int verse,
              }) => PlaceVersesCompanion.insert(
                id: id,
                placeId: placeId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaceVersesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({placeId = false}) {
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
                    if (placeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.placeId,
                                referencedTable: $$PlaceVersesTableReferences
                                    ._placeIdTable(db),
                                referencedColumn: $$PlaceVersesTableReferences
                                    ._placeIdTable(db)
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

typedef $$PlaceVersesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PlaceVersesTable,
      PlaceVerse,
      $$PlaceVersesTableFilterComposer,
      $$PlaceVersesTableOrderingComposer,
      $$PlaceVersesTableAnnotationComposer,
      $$PlaceVersesTableCreateCompanionBuilder,
      $$PlaceVersesTableUpdateCompanionBuilder,
      (PlaceVerse, $$PlaceVersesTableReferences),
      PlaceVerse,
      PrefetchHooks Function({bool placeId})
    >;
typedef $$BiblePeopleTableCreateCompanionBuilder =
    BiblePeopleCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      required String displayTitle,
      Value<String?> gender,
      Value<String?> alsoCalled,
      Value<int?> birthYear,
      Value<int?> deathYear,
      Value<int?> minYear,
      Value<int?> maxYear,
      Value<int?> fatherId,
      Value<int?> motherId,
      Value<String?> bio,
      required int verseCount,
    });
typedef $$BiblePeopleTableUpdateCompanionBuilder =
    BiblePeopleCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<String> displayTitle,
      Value<String?> gender,
      Value<String?> alsoCalled,
      Value<int?> birthYear,
      Value<int?> deathYear,
      Value<int?> minYear,
      Value<int?> maxYear,
      Value<int?> fatherId,
      Value<int?> motherId,
      Value<String?> bio,
      Value<int> verseCount,
    });

final class $$BiblePeopleTableReferences
    extends BaseReferences<_$ContentStore, $BiblePeopleTable, BiblePerson> {
  $$BiblePeopleTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PersonVersesTable, List<PersonVerse>>
  _personVersesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.personVerses,
    aliasName: 'bible_people__id__person_verses__person_id',
  );

  $$PersonVersesTableProcessedTableManager get personVersesRefs {
    final manager = $$PersonVersesTableTableManager(
      $_db,
      $_db.personVerses,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_personVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PeopleGroupMembersTable, List<PeopleGroupMember>>
  _peopleGroupMembersRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.peopleGroupMembers,
        aliasName: 'bible_people__id__people_group_members__person_id',
      );

  $$PeopleGroupMembersTableProcessedTableManager get peopleGroupMembersRefs {
    final manager = $$PeopleGroupMembersTableTableManager(
      $_db,
      $_db.peopleGroupMembers,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _peopleGroupMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventParticipantsTable, List<EventParticipant>>
  _eventParticipantsRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.eventParticipants,
        aliasName: 'bible_people__id__event_participants__person_id',
      );

  $$EventParticipantsTableProcessedTableManager get eventParticipantsRefs {
    final manager = $$EventParticipantsTableTableManager(
      $_db,
      $_db.eventParticipants,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BiblePeopleTableFilterComposer
    extends Composer<_$ContentStore, $BiblePeopleTable> {
  $$BiblePeopleTableFilterComposer({
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

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alsoCalled => $composableBuilder(
    column: $table.alsoCalled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deathYear => $composableBuilder(
    column: $table.deathYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minYear => $composableBuilder(
    column: $table.minYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxYear => $composableBuilder(
    column: $table.maxYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fatherId => $composableBuilder(
    column: $table.fatherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get motherId => $composableBuilder(
    column: $table.motherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verseCount => $composableBuilder(
    column: $table.verseCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> personVersesRefs(
    Expression<bool> Function($$PersonVersesTableFilterComposer f) f,
  ) {
    final $$PersonVersesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personVerses,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonVersesTableFilterComposer(
            $db: $db,
            $table: $db.personVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> peopleGroupMembersRefs(
    Expression<bool> Function($$PeopleGroupMembersTableFilterComposer f) f,
  ) {
    final $$PeopleGroupMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.peopleGroupMembers,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleGroupMembersTableFilterComposer(
            $db: $db,
            $table: $db.peopleGroupMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventParticipantsRefs(
    Expression<bool> Function($$EventParticipantsTableFilterComposer f) f,
  ) {
    final $$EventParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventParticipants,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.eventParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BiblePeopleTableOrderingComposer
    extends Composer<_$ContentStore, $BiblePeopleTable> {
  $$BiblePeopleTableOrderingComposer({
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

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alsoCalled => $composableBuilder(
    column: $table.alsoCalled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deathYear => $composableBuilder(
    column: $table.deathYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minYear => $composableBuilder(
    column: $table.minYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxYear => $composableBuilder(
    column: $table.maxYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fatherId => $composableBuilder(
    column: $table.fatherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get motherId => $composableBuilder(
    column: $table.motherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verseCount => $composableBuilder(
    column: $table.verseCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BiblePeopleTableAnnotationComposer
    extends Composer<_$ContentStore, $BiblePeopleTable> {
  $$BiblePeopleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get alsoCalled => $composableBuilder(
    column: $table.alsoCalled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<int> get deathYear =>
      $composableBuilder(column: $table.deathYear, builder: (column) => column);

  GeneratedColumn<int> get minYear =>
      $composableBuilder(column: $table.minYear, builder: (column) => column);

  GeneratedColumn<int> get maxYear =>
      $composableBuilder(column: $table.maxYear, builder: (column) => column);

  GeneratedColumn<int> get fatherId =>
      $composableBuilder(column: $table.fatherId, builder: (column) => column);

  GeneratedColumn<int> get motherId =>
      $composableBuilder(column: $table.motherId, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<int> get verseCount => $composableBuilder(
    column: $table.verseCount,
    builder: (column) => column,
  );

  Expression<T> personVersesRefs<T extends Object>(
    Expression<T> Function($$PersonVersesTableAnnotationComposer a) f,
  ) {
    final $$PersonVersesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personVerses,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonVersesTableAnnotationComposer(
            $db: $db,
            $table: $db.personVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> peopleGroupMembersRefs<T extends Object>(
    Expression<T> Function($$PeopleGroupMembersTableAnnotationComposer a) f,
  ) {
    final $$PeopleGroupMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.peopleGroupMembers,
          getReferencedColumn: (t) => t.personId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PeopleGroupMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.peopleGroupMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventParticipantsRefs<T extends Object>(
    Expression<T> Function($$EventParticipantsTableAnnotationComposer a) f,
  ) {
    final $$EventParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventParticipants,
          getReferencedColumn: (t) => t.personId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BiblePeopleTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $BiblePeopleTable,
          BiblePerson,
          $$BiblePeopleTableFilterComposer,
          $$BiblePeopleTableOrderingComposer,
          $$BiblePeopleTableAnnotationComposer,
          $$BiblePeopleTableCreateCompanionBuilder,
          $$BiblePeopleTableUpdateCompanionBuilder,
          (BiblePerson, $$BiblePeopleTableReferences),
          BiblePerson,
          PrefetchHooks Function({
            bool personVersesRefs,
            bool peopleGroupMembersRefs,
            bool eventParticipantsRefs,
          })
        > {
  $$BiblePeopleTableTableManager(_$ContentStore db, $BiblePeopleTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BiblePeopleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BiblePeopleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BiblePeopleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> displayTitle = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> alsoCalled = const Value.absent(),
                Value<int?> birthYear = const Value.absent(),
                Value<int?> deathYear = const Value.absent(),
                Value<int?> minYear = const Value.absent(),
                Value<int?> maxYear = const Value.absent(),
                Value<int?> fatherId = const Value.absent(),
                Value<int?> motherId = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<int> verseCount = const Value.absent(),
              }) => BiblePeopleCompanion(
                id: id,
                slug: slug,
                name: name,
                displayTitle: displayTitle,
                gender: gender,
                alsoCalled: alsoCalled,
                birthYear: birthYear,
                deathYear: deathYear,
                minYear: minYear,
                maxYear: maxYear,
                fatherId: fatherId,
                motherId: motherId,
                bio: bio,
                verseCount: verseCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                required String displayTitle,
                Value<String?> gender = const Value.absent(),
                Value<String?> alsoCalled = const Value.absent(),
                Value<int?> birthYear = const Value.absent(),
                Value<int?> deathYear = const Value.absent(),
                Value<int?> minYear = const Value.absent(),
                Value<int?> maxYear = const Value.absent(),
                Value<int?> fatherId = const Value.absent(),
                Value<int?> motherId = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                required int verseCount,
              }) => BiblePeopleCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                displayTitle: displayTitle,
                gender: gender,
                alsoCalled: alsoCalled,
                birthYear: birthYear,
                deathYear: deathYear,
                minYear: minYear,
                maxYear: maxYear,
                fatherId: fatherId,
                motherId: motherId,
                bio: bio,
                verseCount: verseCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BiblePeopleTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                personVersesRefs = false,
                peopleGroupMembersRefs = false,
                eventParticipantsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (personVersesRefs) db.personVerses,
                    if (peopleGroupMembersRefs) db.peopleGroupMembers,
                    if (eventParticipantsRefs) db.eventParticipants,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (personVersesRefs)
                        await $_getPrefetchedData<
                          BiblePerson,
                          $BiblePeopleTable,
                          PersonVerse
                        >(
                          currentTable: table,
                          referencedTable: $$BiblePeopleTableReferences
                              ._personVersesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BiblePeopleTableReferences(
                                db,
                                table,
                                p0,
                              ).personVersesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (peopleGroupMembersRefs)
                        await $_getPrefetchedData<
                          BiblePerson,
                          $BiblePeopleTable,
                          PeopleGroupMember
                        >(
                          currentTable: table,
                          referencedTable: $$BiblePeopleTableReferences
                              ._peopleGroupMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BiblePeopleTableReferences(
                                db,
                                table,
                                p0,
                              ).peopleGroupMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventParticipantsRefs)
                        await $_getPrefetchedData<
                          BiblePerson,
                          $BiblePeopleTable,
                          EventParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$BiblePeopleTableReferences
                              ._eventParticipantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BiblePeopleTableReferences(
                                db,
                                table,
                                p0,
                              ).eventParticipantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BiblePeopleTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $BiblePeopleTable,
      BiblePerson,
      $$BiblePeopleTableFilterComposer,
      $$BiblePeopleTableOrderingComposer,
      $$BiblePeopleTableAnnotationComposer,
      $$BiblePeopleTableCreateCompanionBuilder,
      $$BiblePeopleTableUpdateCompanionBuilder,
      (BiblePerson, $$BiblePeopleTableReferences),
      BiblePerson,
      PrefetchHooks Function({
        bool personVersesRefs,
        bool peopleGroupMembersRefs,
        bool eventParticipantsRefs,
      })
    >;
typedef $$PersonPartnersTableCreateCompanionBuilder =
    PersonPartnersCompanion Function({
      Value<int> id,
      required int personId,
      required int partnerId,
    });
typedef $$PersonPartnersTableUpdateCompanionBuilder =
    PersonPartnersCompanion Function({
      Value<int> id,
      Value<int> personId,
      Value<int> partnerId,
    });

final class $$PersonPartnersTableReferences
    extends
        BaseReferences<_$ContentStore, $PersonPartnersTable, PersonPartner> {
  $$PersonPartnersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BiblePeopleTable _personIdTable(_$ContentStore db) => db.biblePeople
      .createAlias('person_partners__person_id__bible_people__id');

  $$BiblePeopleTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$BiblePeopleTableTableManager(
      $_db,
      $_db.biblePeople,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BiblePeopleTable _partnerIdTable(_$ContentStore db) => db.biblePeople
      .createAlias('person_partners__partner_id__bible_people__id');

  $$BiblePeopleTableProcessedTableManager get partnerId {
    final $_column = $_itemColumn<int>('partner_id')!;

    final manager = $$BiblePeopleTableTableManager(
      $_db,
      $_db.biblePeople,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partnerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PersonPartnersTableFilterComposer
    extends Composer<_$ContentStore, $PersonPartnersTable> {
  $$PersonPartnersTableFilterComposer({
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

  $$BiblePeopleTableFilterComposer get personId {
    final $$BiblePeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableFilterComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableFilterComposer get partnerId {
    final $$BiblePeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableFilterComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonPartnersTableOrderingComposer
    extends Composer<_$ContentStore, $PersonPartnersTable> {
  $$PersonPartnersTableOrderingComposer({
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

  $$BiblePeopleTableOrderingComposer get personId {
    final $$BiblePeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableOrderingComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableOrderingComposer get partnerId {
    final $$BiblePeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableOrderingComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonPartnersTableAnnotationComposer
    extends Composer<_$ContentStore, $PersonPartnersTable> {
  $$PersonPartnersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$BiblePeopleTableAnnotationComposer get personId {
    final $$BiblePeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableAnnotationComposer get partnerId {
    final $$BiblePeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonPartnersTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PersonPartnersTable,
          PersonPartner,
          $$PersonPartnersTableFilterComposer,
          $$PersonPartnersTableOrderingComposer,
          $$PersonPartnersTableAnnotationComposer,
          $$PersonPartnersTableCreateCompanionBuilder,
          $$PersonPartnersTableUpdateCompanionBuilder,
          (PersonPartner, $$PersonPartnersTableReferences),
          PersonPartner,
          PrefetchHooks Function({bool personId, bool partnerId})
        > {
  $$PersonPartnersTableTableManager(
    _$ContentStore db,
    $PersonPartnersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonPartnersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonPartnersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonPartnersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> personId = const Value.absent(),
                Value<int> partnerId = const Value.absent(),
              }) => PersonPartnersCompanion(
                id: id,
                personId: personId,
                partnerId: partnerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int personId,
                required int partnerId,
              }) => PersonPartnersCompanion.insert(
                id: id,
                personId: personId,
                partnerId: partnerId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonPartnersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({personId = false, partnerId = false}) {
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
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable: $$PersonPartnersTableReferences
                                    ._personIdTable(db),
                                referencedColumn:
                                    $$PersonPartnersTableReferences
                                        ._personIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (partnerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.partnerId,
                                referencedTable: $$PersonPartnersTableReferences
                                    ._partnerIdTable(db),
                                referencedColumn:
                                    $$PersonPartnersTableReferences
                                        ._partnerIdTable(db)
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

typedef $$PersonPartnersTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PersonPartnersTable,
      PersonPartner,
      $$PersonPartnersTableFilterComposer,
      $$PersonPartnersTableOrderingComposer,
      $$PersonPartnersTableAnnotationComposer,
      $$PersonPartnersTableCreateCompanionBuilder,
      $$PersonPartnersTableUpdateCompanionBuilder,
      (PersonPartner, $$PersonPartnersTableReferences),
      PersonPartner,
      PrefetchHooks Function({bool personId, bool partnerId})
    >;
typedef $$PersonVersesTableCreateCompanionBuilder =
    PersonVersesCompanion Function({
      Value<int> id,
      required int personId,
      required String bookName,
      required int chapter,
      required int verse,
    });
typedef $$PersonVersesTableUpdateCompanionBuilder =
    PersonVersesCompanion Function({
      Value<int> id,
      Value<int> personId,
      Value<String> bookName,
      Value<int> chapter,
      Value<int> verse,
    });

final class $$PersonVersesTableReferences
    extends BaseReferences<_$ContentStore, $PersonVersesTable, PersonVerse> {
  $$PersonVersesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BiblePeopleTable _personIdTable(_$ContentStore db) =>
      db.biblePeople.createAlias('person_verses__person_id__bible_people__id');

  $$BiblePeopleTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$BiblePeopleTableTableManager(
      $_db,
      $_db.biblePeople,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PersonVersesTableFilterComposer
    extends Composer<_$ContentStore, $PersonVersesTable> {
  $$PersonVersesTableFilterComposer({
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

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$BiblePeopleTableFilterComposer get personId {
    final $$BiblePeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableFilterComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonVersesTableOrderingComposer
    extends Composer<_$ContentStore, $PersonVersesTable> {
  $$PersonVersesTableOrderingComposer({
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

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$BiblePeopleTableOrderingComposer get personId {
    final $$BiblePeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableOrderingComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonVersesTableAnnotationComposer
    extends Composer<_$ContentStore, $PersonVersesTable> {
  $$PersonVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  $$BiblePeopleTableAnnotationComposer get personId {
    final $$BiblePeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonVersesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PersonVersesTable,
          PersonVerse,
          $$PersonVersesTableFilterComposer,
          $$PersonVersesTableOrderingComposer,
          $$PersonVersesTableAnnotationComposer,
          $$PersonVersesTableCreateCompanionBuilder,
          $$PersonVersesTableUpdateCompanionBuilder,
          (PersonVerse, $$PersonVersesTableReferences),
          PersonVerse,
          PrefetchHooks Function({bool personId})
        > {
  $$PersonVersesTableTableManager(_$ContentStore db, $PersonVersesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> personId = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
              }) => PersonVersesCompanion(
                id: id,
                personId: personId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int personId,
                required String bookName,
                required int chapter,
                required int verse,
              }) => PersonVersesCompanion.insert(
                id: id,
                personId: personId,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonVersesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({personId = false}) {
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
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable: $$PersonVersesTableReferences
                                    ._personIdTable(db),
                                referencedColumn: $$PersonVersesTableReferences
                                    ._personIdTable(db)
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

typedef $$PersonVersesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PersonVersesTable,
      PersonVerse,
      $$PersonVersesTableFilterComposer,
      $$PersonVersesTableOrderingComposer,
      $$PersonVersesTableAnnotationComposer,
      $$PersonVersesTableCreateCompanionBuilder,
      $$PersonVersesTableUpdateCompanionBuilder,
      (PersonVerse, $$PersonVersesTableReferences),
      PersonVerse,
      PrefetchHooks Function({bool personId})
    >;
typedef $$PeopleGroupsTableCreateCompanionBuilder =
    PeopleGroupsCompanion Function({Value<int> id, required String name});
typedef $$PeopleGroupsTableUpdateCompanionBuilder =
    PeopleGroupsCompanion Function({Value<int> id, Value<String> name});

final class $$PeopleGroupsTableReferences
    extends BaseReferences<_$ContentStore, $PeopleGroupsTable, PeopleGroup> {
  $$PeopleGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PeopleGroupMembersTable, List<PeopleGroupMember>>
  _peopleGroupMembersRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.peopleGroupMembers,
        aliasName: 'people_groups__id__people_group_members__group_id',
      );

  $$PeopleGroupMembersTableProcessedTableManager get peopleGroupMembersRefs {
    final manager = $$PeopleGroupMembersTableTableManager(
      $_db,
      $_db.peopleGroupMembers,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _peopleGroupMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PeopleGroupsTableFilterComposer
    extends Composer<_$ContentStore, $PeopleGroupsTable> {
  $$PeopleGroupsTableFilterComposer({
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

  Expression<bool> peopleGroupMembersRefs(
    Expression<bool> Function($$PeopleGroupMembersTableFilterComposer f) f,
  ) {
    final $$PeopleGroupMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.peopleGroupMembers,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleGroupMembersTableFilterComposer(
            $db: $db,
            $table: $db.peopleGroupMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PeopleGroupsTableOrderingComposer
    extends Composer<_$ContentStore, $PeopleGroupsTable> {
  $$PeopleGroupsTableOrderingComposer({
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
}

class $$PeopleGroupsTableAnnotationComposer
    extends Composer<_$ContentStore, $PeopleGroupsTable> {
  $$PeopleGroupsTableAnnotationComposer({
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

  Expression<T> peopleGroupMembersRefs<T extends Object>(
    Expression<T> Function($$PeopleGroupMembersTableAnnotationComposer a) f,
  ) {
    final $$PeopleGroupMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.peopleGroupMembers,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PeopleGroupMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.peopleGroupMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PeopleGroupsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PeopleGroupsTable,
          PeopleGroup,
          $$PeopleGroupsTableFilterComposer,
          $$PeopleGroupsTableOrderingComposer,
          $$PeopleGroupsTableAnnotationComposer,
          $$PeopleGroupsTableCreateCompanionBuilder,
          $$PeopleGroupsTableUpdateCompanionBuilder,
          (PeopleGroup, $$PeopleGroupsTableReferences),
          PeopleGroup,
          PrefetchHooks Function({bool peopleGroupMembersRefs})
        > {
  $$PeopleGroupsTableTableManager(_$ContentStore db, $PeopleGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeopleGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeopleGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeopleGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => PeopleGroupsCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  PeopleGroupsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PeopleGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({peopleGroupMembersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (peopleGroupMembersRefs) db.peopleGroupMembers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (peopleGroupMembersRefs)
                    await $_getPrefetchedData<
                      PeopleGroup,
                      $PeopleGroupsTable,
                      PeopleGroupMember
                    >(
                      currentTable: table,
                      referencedTable: $$PeopleGroupsTableReferences
                          ._peopleGroupMembersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PeopleGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).peopleGroupMembersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PeopleGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PeopleGroupsTable,
      PeopleGroup,
      $$PeopleGroupsTableFilterComposer,
      $$PeopleGroupsTableOrderingComposer,
      $$PeopleGroupsTableAnnotationComposer,
      $$PeopleGroupsTableCreateCompanionBuilder,
      $$PeopleGroupsTableUpdateCompanionBuilder,
      (PeopleGroup, $$PeopleGroupsTableReferences),
      PeopleGroup,
      PrefetchHooks Function({bool peopleGroupMembersRefs})
    >;
typedef $$PeopleGroupMembersTableCreateCompanionBuilder =
    PeopleGroupMembersCompanion Function({
      Value<int> id,
      required int groupId,
      required int personId,
    });
typedef $$PeopleGroupMembersTableUpdateCompanionBuilder =
    PeopleGroupMembersCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<int> personId,
    });

final class $$PeopleGroupMembersTableReferences
    extends
        BaseReferences<
          _$ContentStore,
          $PeopleGroupMembersTable,
          PeopleGroupMember
        > {
  $$PeopleGroupMembersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PeopleGroupsTable _groupIdTable(_$ContentStore db) => db.peopleGroups
      .createAlias('people_group_members__group_id__people_groups__id');

  $$PeopleGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$PeopleGroupsTableTableManager(
      $_db,
      $_db.peopleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BiblePeopleTable _personIdTable(_$ContentStore db) => db.biblePeople
      .createAlias('people_group_members__person_id__bible_people__id');

  $$BiblePeopleTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$BiblePeopleTableTableManager(
      $_db,
      $_db.biblePeople,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PeopleGroupMembersTableFilterComposer
    extends Composer<_$ContentStore, $PeopleGroupMembersTable> {
  $$PeopleGroupMembersTableFilterComposer({
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

  $$PeopleGroupsTableFilterComposer get groupId {
    final $$PeopleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.peopleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.peopleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableFilterComposer get personId {
    final $$BiblePeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableFilterComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeopleGroupMembersTableOrderingComposer
    extends Composer<_$ContentStore, $PeopleGroupMembersTable> {
  $$PeopleGroupMembersTableOrderingComposer({
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

  $$PeopleGroupsTableOrderingComposer get groupId {
    final $$PeopleGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.peopleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.peopleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableOrderingComposer get personId {
    final $$BiblePeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableOrderingComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeopleGroupMembersTableAnnotationComposer
    extends Composer<_$ContentStore, $PeopleGroupMembersTable> {
  $$PeopleGroupMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$PeopleGroupsTableAnnotationComposer get groupId {
    final $$PeopleGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.peopleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PeopleGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.peopleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableAnnotationComposer get personId {
    final $$BiblePeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PeopleGroupMembersTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $PeopleGroupMembersTable,
          PeopleGroupMember,
          $$PeopleGroupMembersTableFilterComposer,
          $$PeopleGroupMembersTableOrderingComposer,
          $$PeopleGroupMembersTableAnnotationComposer,
          $$PeopleGroupMembersTableCreateCompanionBuilder,
          $$PeopleGroupMembersTableUpdateCompanionBuilder,
          (PeopleGroupMember, $$PeopleGroupMembersTableReferences),
          PeopleGroupMember,
          PrefetchHooks Function({bool groupId, bool personId})
        > {
  $$PeopleGroupMembersTableTableManager(
    _$ContentStore db,
    $PeopleGroupMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeopleGroupMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeopleGroupMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeopleGroupMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<int> personId = const Value.absent(),
              }) => PeopleGroupMembersCompanion(
                id: id,
                groupId: groupId,
                personId: personId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                required int personId,
              }) => PeopleGroupMembersCompanion.insert(
                id: id,
                groupId: groupId,
                personId: personId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PeopleGroupMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false, personId = false}) {
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
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable:
                                    $$PeopleGroupMembersTableReferences
                                        ._groupIdTable(db),
                                referencedColumn:
                                    $$PeopleGroupMembersTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable:
                                    $$PeopleGroupMembersTableReferences
                                        ._personIdTable(db),
                                referencedColumn:
                                    $$PeopleGroupMembersTableReferences
                                        ._personIdTable(db)
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

typedef $$PeopleGroupMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $PeopleGroupMembersTable,
      PeopleGroupMember,
      $$PeopleGroupMembersTableFilterComposer,
      $$PeopleGroupMembersTableOrderingComposer,
      $$PeopleGroupMembersTableAnnotationComposer,
      $$PeopleGroupMembersTableCreateCompanionBuilder,
      $$PeopleGroupMembersTableUpdateCompanionBuilder,
      (PeopleGroupMember, $$PeopleGroupMembersTableReferences),
      PeopleGroupMember,
      PrefetchHooks Function({bool groupId, bool personId})
    >;
typedef $$TimelineEventsTableCreateCompanionBuilder =
    TimelineEventsCompanion Function({
      Value<int> id,
      required String title,
      Value<double?> sortKey,
      Value<int?> startYear,
    });
typedef $$TimelineEventsTableUpdateCompanionBuilder =
    TimelineEventsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<double?> sortKey,
      Value<int?> startYear,
    });

final class $$TimelineEventsTableReferences
    extends
        BaseReferences<_$ContentStore, $TimelineEventsTable, TimelineEvent> {
  $$TimelineEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EventParticipantsTable, List<EventParticipant>>
  _eventParticipantsRefsTable(_$ContentStore db) =>
      MultiTypedResultKey.fromTable(
        db.eventParticipants,
        aliasName: 'timeline_events__id__event_participants__event_id',
      );

  $$EventParticipantsTableProcessedTableManager get eventParticipantsRefs {
    final manager = $$EventParticipantsTableTableManager(
      $_db,
      $_db.eventParticipants,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventParticipantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventVersesTable, List<EventVerse>>
  _eventVersesRefsTable(_$ContentStore db) => MultiTypedResultKey.fromTable(
    db.eventVerses,
    aliasName: 'timeline_events__id__event_verses__event_id',
  );

  $$EventVersesTableProcessedTableManager get eventVersesRefs {
    final manager = $$EventVersesTableTableManager(
      $_db,
      $_db.eventVerses,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventVersesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TimelineEventsTableFilterComposer
    extends Composer<_$ContentStore, $TimelineEventsTable> {
  $$TimelineEventsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sortKey => $composableBuilder(
    column: $table.sortKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startYear => $composableBuilder(
    column: $table.startYear,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventParticipantsRefs(
    Expression<bool> Function($$EventParticipantsTableFilterComposer f) f,
  ) {
    final $$EventParticipantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventParticipants,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventParticipantsTableFilterComposer(
            $db: $db,
            $table: $db.eventParticipants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventVersesRefs(
    Expression<bool> Function($$EventVersesTableFilterComposer f) f,
  ) {
    final $$EventVersesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventVerses,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventVersesTableFilterComposer(
            $db: $db,
            $table: $db.eventVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimelineEventsTableOrderingComposer
    extends Composer<_$ContentStore, $TimelineEventsTable> {
  $$TimelineEventsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sortKey => $composableBuilder(
    column: $table.sortKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startYear => $composableBuilder(
    column: $table.startYear,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimelineEventsTableAnnotationComposer
    extends Composer<_$ContentStore, $TimelineEventsTable> {
  $$TimelineEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get sortKey =>
      $composableBuilder(column: $table.sortKey, builder: (column) => column);

  GeneratedColumn<int> get startYear =>
      $composableBuilder(column: $table.startYear, builder: (column) => column);

  Expression<T> eventParticipantsRefs<T extends Object>(
    Expression<T> Function($$EventParticipantsTableAnnotationComposer a) f,
  ) {
    final $$EventParticipantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventParticipants,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventParticipantsTableAnnotationComposer(
                $db: $db,
                $table: $db.eventParticipants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> eventVersesRefs<T extends Object>(
    Expression<T> Function($$EventVersesTableAnnotationComposer a) f,
  ) {
    final $$EventVersesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventVerses,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventVersesTableAnnotationComposer(
            $db: $db,
            $table: $db.eventVerses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TimelineEventsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $TimelineEventsTable,
          TimelineEvent,
          $$TimelineEventsTableFilterComposer,
          $$TimelineEventsTableOrderingComposer,
          $$TimelineEventsTableAnnotationComposer,
          $$TimelineEventsTableCreateCompanionBuilder,
          $$TimelineEventsTableUpdateCompanionBuilder,
          (TimelineEvent, $$TimelineEventsTableReferences),
          TimelineEvent,
          PrefetchHooks Function({
            bool eventParticipantsRefs,
            bool eventVersesRefs,
          })
        > {
  $$TimelineEventsTableTableManager(
    _$ContentStore db,
    $TimelineEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimelineEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimelineEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimelineEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double?> sortKey = const Value.absent(),
                Value<int?> startYear = const Value.absent(),
              }) => TimelineEventsCompanion(
                id: id,
                title: title,
                sortKey: sortKey,
                startYear: startYear,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<double?> sortKey = const Value.absent(),
                Value<int?> startYear = const Value.absent(),
              }) => TimelineEventsCompanion.insert(
                id: id,
                title: title,
                sortKey: sortKey,
                startYear: startYear,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimelineEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventParticipantsRefs = false, eventVersesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventParticipantsRefs) db.eventParticipants,
                    if (eventVersesRefs) db.eventVerses,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventParticipantsRefs)
                        await $_getPrefetchedData<
                          TimelineEvent,
                          $TimelineEventsTable,
                          EventParticipant
                        >(
                          currentTable: table,
                          referencedTable: $$TimelineEventsTableReferences
                              ._eventParticipantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimelineEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventParticipantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventVersesRefs)
                        await $_getPrefetchedData<
                          TimelineEvent,
                          $TimelineEventsTable,
                          EventVerse
                        >(
                          currentTable: table,
                          referencedTable: $$TimelineEventsTableReferences
                              ._eventVersesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TimelineEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventVersesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TimelineEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $TimelineEventsTable,
      TimelineEvent,
      $$TimelineEventsTableFilterComposer,
      $$TimelineEventsTableOrderingComposer,
      $$TimelineEventsTableAnnotationComposer,
      $$TimelineEventsTableCreateCompanionBuilder,
      $$TimelineEventsTableUpdateCompanionBuilder,
      (TimelineEvent, $$TimelineEventsTableReferences),
      TimelineEvent,
      PrefetchHooks Function({bool eventParticipantsRefs, bool eventVersesRefs})
    >;
typedef $$EventParticipantsTableCreateCompanionBuilder =
    EventParticipantsCompanion Function({
      Value<int> id,
      required int eventId,
      required int personId,
    });
typedef $$EventParticipantsTableUpdateCompanionBuilder =
    EventParticipantsCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<int> personId,
    });

final class $$EventParticipantsTableReferences
    extends
        BaseReferences<
          _$ContentStore,
          $EventParticipantsTable,
          EventParticipant
        > {
  $$EventParticipantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TimelineEventsTable _eventIdTable(_$ContentStore db) => db
      .timelineEvents
      .createAlias('event_participants__event_id__timeline_events__id');

  $$TimelineEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$TimelineEventsTableTableManager(
      $_db,
      $_db.timelineEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BiblePeopleTable _personIdTable(_$ContentStore db) => db.biblePeople
      .createAlias('event_participants__person_id__bible_people__id');

  $$BiblePeopleTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$BiblePeopleTableTableManager(
      $_db,
      $_db.biblePeople,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventParticipantsTableFilterComposer
    extends Composer<_$ContentStore, $EventParticipantsTable> {
  $$EventParticipantsTableFilterComposer({
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

  $$TimelineEventsTableFilterComposer get eventId {
    final $$TimelineEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableFilterComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableFilterComposer get personId {
    final $$BiblePeopleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableFilterComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventParticipantsTableOrderingComposer
    extends Composer<_$ContentStore, $EventParticipantsTable> {
  $$EventParticipantsTableOrderingComposer({
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

  $$TimelineEventsTableOrderingComposer get eventId {
    final $$TimelineEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableOrderingComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableOrderingComposer get personId {
    final $$BiblePeopleTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableOrderingComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventParticipantsTableAnnotationComposer
    extends Composer<_$ContentStore, $EventParticipantsTable> {
  $$EventParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$TimelineEventsTableAnnotationComposer get eventId {
    final $$TimelineEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BiblePeopleTableAnnotationComposer get personId {
    final $$BiblePeopleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.biblePeople,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePeopleTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePeople,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventParticipantsTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $EventParticipantsTable,
          EventParticipant,
          $$EventParticipantsTableFilterComposer,
          $$EventParticipantsTableOrderingComposer,
          $$EventParticipantsTableAnnotationComposer,
          $$EventParticipantsTableCreateCompanionBuilder,
          $$EventParticipantsTableUpdateCompanionBuilder,
          (EventParticipant, $$EventParticipantsTableReferences),
          EventParticipant,
          PrefetchHooks Function({bool eventId, bool personId})
        > {
  $$EventParticipantsTableTableManager(
    _$ContentStore db,
    $EventParticipantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventParticipantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventParticipantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<int> personId = const Value.absent(),
              }) => EventParticipantsCompanion(
                id: id,
                eventId: eventId,
                personId: personId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required int personId,
              }) => EventParticipantsCompanion.insert(
                id: id,
                eventId: eventId,
                personId: personId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventParticipantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, personId = false}) {
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
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable:
                                    $$EventParticipantsTableReferences
                                        ._eventIdTable(db),
                                referencedColumn:
                                    $$EventParticipantsTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable:
                                    $$EventParticipantsTableReferences
                                        ._personIdTable(db),
                                referencedColumn:
                                    $$EventParticipantsTableReferences
                                        ._personIdTable(db)
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

typedef $$EventParticipantsTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $EventParticipantsTable,
      EventParticipant,
      $$EventParticipantsTableFilterComposer,
      $$EventParticipantsTableOrderingComposer,
      $$EventParticipantsTableAnnotationComposer,
      $$EventParticipantsTableCreateCompanionBuilder,
      $$EventParticipantsTableUpdateCompanionBuilder,
      (EventParticipant, $$EventParticipantsTableReferences),
      EventParticipant,
      PrefetchHooks Function({bool eventId, bool personId})
    >;
typedef $$EventVersesTableCreateCompanionBuilder =
    EventVersesCompanion Function({
      Value<int> id,
      required int eventId,
      required int ord,
      required String bookName,
      required int chapter,
      required int verse,
    });
typedef $$EventVersesTableUpdateCompanionBuilder =
    EventVersesCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<int> ord,
      Value<String> bookName,
      Value<int> chapter,
      Value<int> verse,
    });

final class $$EventVersesTableReferences
    extends BaseReferences<_$ContentStore, $EventVersesTable, EventVerse> {
  $$EventVersesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TimelineEventsTable _eventIdTable(_$ContentStore db) => db
      .timelineEvents
      .createAlias('event_verses__event_id__timeline_events__id');

  $$TimelineEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$TimelineEventsTableTableManager(
      $_db,
      $_db.timelineEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventVersesTableFilterComposer
    extends Composer<_$ContentStore, $EventVersesTable> {
  $$EventVersesTableFilterComposer({
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

  ColumnFilters<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$TimelineEventsTableFilterComposer get eventId {
    final $$TimelineEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableFilterComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventVersesTableOrderingComposer
    extends Composer<_$ContentStore, $EventVersesTable> {
  $$EventVersesTableOrderingComposer({
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

  ColumnOrderings<int> get ord => $composableBuilder(
    column: $table.ord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookName => $composableBuilder(
    column: $table.bookName,
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

  $$TimelineEventsTableOrderingComposer get eventId {
    final $$TimelineEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableOrderingComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventVersesTableAnnotationComposer
    extends Composer<_$ContentStore, $EventVersesTable> {
  $$EventVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ord =>
      $composableBuilder(column: $table.ord, builder: (column) => column);

  GeneratedColumn<String> get bookName =>
      $composableBuilder(column: $table.bookName, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  $$TimelineEventsTableAnnotationComposer get eventId {
    final $$TimelineEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.timelineEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimelineEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.timelineEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventVersesTableTableManager
    extends
        RootTableManager<
          _$ContentStore,
          $EventVersesTable,
          EventVerse,
          $$EventVersesTableFilterComposer,
          $$EventVersesTableOrderingComposer,
          $$EventVersesTableAnnotationComposer,
          $$EventVersesTableCreateCompanionBuilder,
          $$EventVersesTableUpdateCompanionBuilder,
          (EventVerse, $$EventVersesTableReferences),
          EventVerse,
          PrefetchHooks Function({bool eventId})
        > {
  $$EventVersesTableTableManager(_$ContentStore db, $EventVersesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<int> ord = const Value.absent(),
                Value<String> bookName = const Value.absent(),
                Value<int> chapter = const Value.absent(),
                Value<int> verse = const Value.absent(),
              }) => EventVersesCompanion(
                id: id,
                eventId: eventId,
                ord: ord,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required int ord,
                required String bookName,
                required int chapter,
                required int verse,
              }) => EventVersesCompanion.insert(
                id: id,
                eventId: eventId,
                ord: ord,
                bookName: bookName,
                chapter: chapter,
                verse: verse,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventVersesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
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
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventVersesTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$EventVersesTableReferences
                                    ._eventIdTable(db)
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

typedef $$EventVersesTableProcessedTableManager =
    ProcessedTableManager<
      _$ContentStore,
      $EventVersesTable,
      EventVerse,
      $$EventVersesTableFilterComposer,
      $$EventVersesTableOrderingComposer,
      $$EventVersesTableAnnotationComposer,
      $$EventVersesTableCreateCompanionBuilder,
      $$EventVersesTableUpdateCompanionBuilder,
      (EventVerse, $$EventVersesTableReferences),
      EventVerse,
      PrefetchHooks Function({bool eventId})
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
  $$CommentariesTableTableManager get commentaries =>
      $$CommentariesTableTableManager(_db, _db.commentaries);
  $$CommentaryEntriesTableTableManager get commentaryEntries =>
      $$CommentaryEntriesTableTableManager(_db, _db.commentaryEntries);
  $$DictionariesTableTableManager get dictionaries =>
      $$DictionariesTableTableManager(_db, _db.dictionaries);
  $$DictionaryEntriesTableTableManager get dictionaryEntries =>
      $$DictionaryEntriesTableTableManager(_db, _db.dictionaryEntries);
  $$SubheadingsTableTableManager get subheadings =>
      $$SubheadingsTableTableManager(_db, _db.subheadings);
  $$DevotionalsTableTableManager get devotionals =>
      $$DevotionalsTableTableManager(_db, _db.devotionals);
  $$DevotionalEntriesTableTableManager get devotionalEntries =>
      $$DevotionalEntriesTableTableManager(_db, _db.devotionalEntries);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$TopicEntriesTableTableManager get topicEntries =>
      $$TopicEntriesTableTableManager(_db, _db.topicEntries);
  $$TopicReferencesTableTableManager get topicReferences =>
      $$TopicReferencesTableTableManager(_db, _db.topicReferences);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$PlaceVersesTableTableManager get placeVerses =>
      $$PlaceVersesTableTableManager(_db, _db.placeVerses);
  $$BiblePeopleTableTableManager get biblePeople =>
      $$BiblePeopleTableTableManager(_db, _db.biblePeople);
  $$PersonPartnersTableTableManager get personPartners =>
      $$PersonPartnersTableTableManager(_db, _db.personPartners);
  $$PersonVersesTableTableManager get personVerses =>
      $$PersonVersesTableTableManager(_db, _db.personVerses);
  $$PeopleGroupsTableTableManager get peopleGroups =>
      $$PeopleGroupsTableTableManager(_db, _db.peopleGroups);
  $$PeopleGroupMembersTableTableManager get peopleGroupMembers =>
      $$PeopleGroupMembersTableTableManager(_db, _db.peopleGroupMembers);
  $$TimelineEventsTableTableManager get timelineEvents =>
      $$TimelineEventsTableTableManager(_db, _db.timelineEvents);
  $$EventParticipantsTableTableManager get eventParticipants =>
      $$EventParticipantsTableTableManager(_db, _db.eventParticipants);
  $$EventVersesTableTableManager get eventVerses =>
      $$EventVersesTableTableManager(_db, _db.eventVerses);
}
