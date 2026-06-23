import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/importer/places_importer.dart';
import 'content_providers.dart';
import 'reader_state.dart';

final placesImporterProvider = Provider<PlacesImporter>(
  (ref) => PlacesImporter(ref.watch(contentStoreProvider)),
);

/// Loads the bundled place geocoding into the DB on first access, then resolves.
final placesReadyProvider = FutureProvider<bool>((ref) async {
  await ref.watch(placesImporterProvider).ensureLoaded();
  return true;
});

/// A geographic place mentioned in the active passage, with the verses (in this
/// chapter) that reference it.
class PlaceInPassage {
  final int id;
  final String name;
  final double lat;
  final double lng;
  final List<int> verses;
  PlaceInPassage({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.verses,
  });
}

/// Places mentioned in (book, chapter) — the "places in this passage" lookup.
final placesForPassageProvider = FutureProvider.family<List<PlaceInPassage>,
    ({String book, int chapter})>((ref, loc) async {
  await ref.watch(placesReadyProvider.future);
  final store = ref.watch(contentStoreProvider);
  final rows = await store.customSelect(
    '''
    SELECT p.id AS id, p.name AS name, p.lat AS lat, p.lng AS lng, pv.verse AS verse
    FROM place_verses pv
    JOIN places p ON p.id = pv.place_id
    WHERE pv.book_name = ? AND pv.chapter = ?
    ORDER BY p.name, pv.verse
    ''',
    variables: [Variable.withString(loc.book), Variable.withInt(loc.chapter)],
  ).get();

  final byId = <int, PlaceInPassage>{};
  for (final r in rows) {
    final id = r.read<int>('id');
    final existing = byId[id];
    final verse = r.read<int>('verse');
    if (existing == null) {
      byId[id] = PlaceInPassage(
        id: id,
        name: r.read<String>('name'),
        lat: r.read<double>('lat'),
        lng: r.read<double>('lng'),
        verses: [verse],
      );
    } else {
      existing.verses.add(verse);
    }
  }
  final list = byId.values.toList()..sort((a, b) => a.name.compareTo(b.name));
  return list;
});

/// Convenience: places for the currently selected book + chapter.
final currentPassagePlacesProvider =
    FutureProvider<List<PlaceInPassage>>((ref) async {
  final book = ref.watch(selectedBookNameProvider);
  final chapter = ref.watch(selectedChapterProvider);
  return ref.watch(placesForPassageProvider((book: book, chapter: chapter)).future);
});

/// The place currently focused in the Places panel/map.
class SelectedPlaceNotifier extends Notifier<int?> {
  @override
  int? build() => null;
  void select(int? id) => state = id;
}

final selectedPlaceProvider =
    NotifierProvider<SelectedPlaceNotifier, int?>(() => SelectedPlaceNotifier());
