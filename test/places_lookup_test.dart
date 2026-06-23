import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/app/content_providers.dart';
import 'package:study_bible/app/place_providers.dart';

/// Exercises the "places in this passage" lookup: places are grouped with the
/// verses (in that chapter) that mention them.
void main() {
  late ContentStore store;
  late ProviderContainer container;

  setUp(() async {
    store = ContentStore(NativeDatabase.memory());

    await store.into(store.places).insert(const PlacesCompanion(
        id: Value(1), name: Value('Nazareth'), lat: Value(32.70), lng: Value(35.30)));
    await store.into(store.places).insert(const PlacesCompanion(
        id: Value(2), name: Value('Bethany'), lat: Value(31.72), lng: Value(35.26)));
    await store.into(store.places).insert(const PlacesCompanion(
        id: Value(3), name: Value('Rome'), lat: Value(41.90), lng: Value(12.50)));

    // John 1: Nazareth (v45, v46), Bethany (v28). Rome only appears elsewhere.
    Future<void> pv(int id, int place, String book, int ch, int v) =>
        store.into(store.placeVerses).insert(PlaceVersesCompanion(
            id: Value(id),
            placeId: Value(place),
            bookName: Value(book),
            chapter: Value(ch),
            verse: Value(v)));
    await pv(1, 1, 'John', 1, 45);
    await pv(2, 1, 'John', 1, 46);
    await pv(3, 2, 'John', 1, 28);
    await pv(4, 3, 'Romans', 1, 7);

    container = ProviderContainer(overrides: [
      contentStoreProvider.overrideWithValue(store),
      placesReadyProvider.overrideWith((ref) async => true),
    ]);
  });

  tearDown(() async {
    container.dispose();
    await store.close();
  });

  Future<List<PlaceInPassage>> placesFor(String book, int ch) => container
      .read(placesForPassageProvider((book: book, chapter: ch)).future);

  test('groups places with their verses for the passage', () async {
    final result = await placesFor('John', 1);
    expect(result.map((p) => p.name).toList(), ['Bethany', 'Nazareth']); // sorted
    final nazareth = result.firstWhere((p) => p.name == 'Nazareth');
    expect(nazareth.verses, [45, 46]);
    final bethany = result.firstWhere((p) => p.name == 'Bethany');
    expect(bethany.verses, [28]);
  });

  test('excludes places not in the passage', () async {
    final result = await placesFor('John', 1);
    expect(result.any((p) => p.name == 'Rome'), isFalse);
  });

  test('a passage with no mapped places returns empty', () async {
    expect(await placesFor('Obadiah', 1), isEmpty);
  });
}
