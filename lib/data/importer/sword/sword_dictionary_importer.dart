import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

import '../../content_store.dart';
import 'segment_html.dart';
import 'sword_config.dart';
import 'sword_ld_reader.dart';
import 'sword_source_parser.dart';

/// Imports a SWORD dictionary/lexicon module (`zLD` compressed or
/// `RawLD`/`RawLD4` uncompressed) into the content store's
/// `dictionaries`/`dictionary_entries` tables.
///
/// Dictionaries are keyed by headword rather than by verse, so they use a
/// [SwordLdReader] (the `.idx/.dat/.zdx/.zdt` key index) instead of the
/// verse readers. Each entry's body is parsed with its `SourceType` filter
/// (usually TEI) and serialised to simple HTML for the dictionary panel.
class SwordDictionaryImporter {
  final ContentStore store;

  SwordDictionaryImporter(this.store);

  /// Import the module described by [config] from the directory tree rooted at
  /// [moduleRoot]. A dictionary's `DataPath` is a file-basename prefix
  /// (e.g. `./modules/lexdict/zld/easton/easton`).
  Future<void> importFromDirectory(
    Directory moduleRoot,
    SwordConfig config,
  ) async {
    final rel = (config.dataPath ?? '').replaceFirst(RegExp(r'^\./'), '');
    final prefix = p.normalize(p.join(moduleRoot.path, rel));
    final reader = await SwordLdReader.fromModuleDirectory(
      Directory(p.dirname(prefix)),
      p.basename(prefix),
      config,
    );
    if (reader == null) {
      throw Exception(
        'No SWORD dictionary data files found for "${config.name}" under '
        '"${p.dirname(prefix)}".',
      );
    }
    await importDictionary(config, reader);
  }

  /// Core import: write the dictionary backed by an already-loaded [reader].
  /// Separated from file resolution so it can be driven in tests.
  Future<void> importDictionary(
    SwordConfig config,
    SwordLdReader reader,
  ) async {
    if (!config.modDrv.isDictionary) {
      throw UnsupportedError(
        'SwordDictionaryImporter handles dictionary modules (zLD/RawLD); '
        'got ModDrv "${config.value('ModDrv')}".',
      );
    }

    final abbr = config.name.toUpperCase();
    final existing = await (store.select(store.dictionaries)
          ..where((d) => d.abbreviation.equals(abbr)))
        .get();
    for (final e in existing) {
      await store.deleteDictionary(e.id);
    }

    final dictionaryId = await store.into(store.dictionaries).insert(
          DictionariesCompanion.insert(
            abbreviation: abbr,
            name: config.description ?? config.name,
            about: config.about != null
                ? Value(config.about)
                : const Value.absent(),
          ),
        );

    final sourceType = config.sourceType;
    final rows = <DictionaryEntriesCompanion>[];
    for (final entry in reader.entries) {
      if (entry.body.trim().isEmpty) continue;
      final parsed = parseSwordSource(entry.body, sourceType);
      final html = segmentsToHtml(parsed.segments);
      if (html.isEmpty) continue;
      rows.add(DictionaryEntriesCompanion.insert(
        dictionaryId: dictionaryId,
        word: entry.key,
        definition: html,
      ));
    }

    if (rows.isEmpty) {
      await store.deleteDictionary(dictionaryId);
      throw Exception(
        'No entries found in SWORD dictionary "${config.name}" — it may use an '
        'unsupported format or be empty.',
      );
    }

    await store
        .batch((batch) => batch.insertAll(store.dictionaryEntries, rows));

    // The dictionary FTS index covers the headword only (matches the MyBible
    // importer and rebuildSearchIndex).
    await store.customStatement(
      '''
      INSERT INTO content_search(type, reference_id, text_content)
      SELECT 'dictionary', id, word
      FROM dictionary_entries
      WHERE dictionary_id = ?
    ''',
      [dictionaryId],
    );
  }
}
