import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/data/importer/sword/sword_config.dart';
import 'package:study_bible/data/importer/sword/sword_dictionary_importer.dart';
import 'package:study_bible/data/importer/sword/sword_ld_reader.dart';

Uint8List _le32(int v) =>
    (ByteData(4)..setUint32(0, v, Endian.little)).buffer.asUint8List();
Uint8List _le16(int v) =>
    (ByteData(2)..setUint16(0, v, Endian.little)).buffer.asUint8List();
Uint8List _concat(List<List<int>> parts) {
  final b = BytesBuilder();
  for (final p in parts) {
    b.add(p);
  }
  return b.toBytes();
}

/// A RawLD reader over TEI bodies for [entries] (key -> body markup).
SwordLdReader _rawReader(Map<String, String> entries) {
  final recs = entries.entries
      .map((e) => utf8.encode('${e.key}\r\n${e.value}'))
      .toList();
  final dat = _concat(recs);
  var off = 0;
  final idx = <List<int>>[];
  for (final r in recs) {
    idx.add(_concat([_le32(off), _le16(r.length)]));
    off += r.length;
  }
  return SwordLdReader.raw(idx: _concat(idx), dat: Uint8List.fromList(dat));
}

void main() {
  late ContentStore store;
  setUp(() => store = ContentStore(NativeDatabase.memory()));
  tearDown(() => store.close());

  final config = SwordConfig.parse('''
[Easton]
ModDrv=RawLD
SourceType=TEI
Encoding=UTF-8
Description=Easton Bible Dictionary
About=A test dictionary.
''');

  SwordLdReader reader() => _rawReader({
        'AARON':
            '<entryFree><title>Aaron</title><p>Brother of Moses.</p></entryFree>',
        'ABADDON':
            '<entryFree><title>Abaddon</title><p>The destroyer.</p></entryFree>',
      });

  test('imports dictionary metadata and entries', () async {
    await SwordDictionaryImporter(store).importDictionary(config, reader());

    final dict = await store.select(store.dictionaries).getSingle();
    expect(dict.abbreviation, 'EASTON');
    expect(dict.name, 'Easton Bible Dictionary');
    expect(dict.about, 'A test dictionary.');

    final entries = await store.select(store.dictionaryEntries).get();
    expect(entries.map((e) => e.word).toSet(), {'AARON', 'ABADDON'});
  });

  test('serialises TEI definitions to HTML', () async {
    await SwordDictionaryImporter(store).importDictionary(config, reader());
    final aaron = await (store.select(store.dictionaryEntries)
          ..where((e) => e.word.equals('AARON')))
        .getSingle();
    expect(aaron.definition, contains('<p>Aaron'));
    expect(aaron.definition, contains('Brother of Moses.'));
    expect(aaron.definition, isNot(contains('<entryFree')));
  });

  test('indexes headwords for search', () async {
    await SwordDictionaryImporter(store).importDictionary(config, reader());
    final rows = await store.customSelect(
      "SELECT reference_id FROM content_search "
      "WHERE type = 'dictionary' AND content_search MATCH 'ABADDON'",
    ).get();
    expect(rows, hasLength(1));
  });

  test('rejects a non-dictionary driver', () async {
    final bible = SwordConfig.parse('[X]\nModDrv=zText\nSourceType=OSIS');
    expect(
      () => SwordDictionaryImporter(store).importDictionary(bible, reader()),
      throwsUnsupportedError,
    );
  });

  test('re-importing replaces the prior dictionary', () async {
    final importer = SwordDictionaryImporter(store);
    await importer.importDictionary(config, reader());
    await importer.importDictionary(config, reader());
    expect(await store.select(store.dictionaries).get(), hasLength(1));
    expect(await store.select(store.dictionaryEntries).get(), hasLength(2));
  });
}
