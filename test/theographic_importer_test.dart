import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/data/importer/theographic_importer.dart';

/// Runs the real importer against the real bundled asset: parse, insert,
/// FTS indexing, and idempotency — the exact path a fresh install takes the
/// first time people data is needed.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ContentStore store;

  setUp(() {
    store = ContentStore(NativeDatabase.memory());
  });

  tearDown(() async {
    await store.close();
  });

  test('imports the bundled dataset and indexes people for search', () async {
    final importer = TheographicImporter(store);
    await importer.ensureLoaded();

    final people = await store.select(store.biblePeople).get();
    expect(people.length, greaterThan(3000));

    final aaron = people.firstWhere((p) => p.slug == 'aaron_1');
    expect(aaron.displayTitle, 'Aaron');
    expect(aaron.bio, contains('eldest son of Amram'));
    final father = await (store.select(store.biblePeople)
          ..where((p) => p.id.equals(aaron.fatherId!)))
        .getSingle();
    expect(father.name, 'Amram');

    // Aaron's verse links landed with real book names.
    final firstVerse = await (store.select(store.personVerses)
          ..where((v) => v.personId.equals(aaron.id))
          ..limit(1))
        .getSingle();
    expect(firstVerse.bookName, 'Exodus');

    // Names (including alternate names) are searchable via the global FTS.
    final hit = await store.customSelect(
      "SELECT reference_id FROM content_search "
      "WHERE type = 'person' AND content_search MATCH '\"Aaron\"' LIMIT 5",
    ).get();
    expect(hit, isNotEmpty);

    // Events imported in chronological order.
    final firstEvent = await (store.select(store.timelineEvents)
          ..where((e) => e.id.equals(1)))
        .getSingle();
    expect(firstEvent.title, contains('Creation'));

    // Second call is a no-op, not a duplicate import.
    await importer.ensureLoaded();
    final recount = await store.select(store.biblePeople).get();
    expect(recount.length, people.length);
  });
}
