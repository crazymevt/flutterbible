import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../content_store.dart';

/// Loads the bundled OpenBible.info place geocoding asset into the content store
/// on first use. Data is CC-BY 4.0 (openbibleinfo/Bible-Geocoding-Data),
/// converted to JSON by `tool/build_places.dart`. Coordinates and verse links
/// are fully offline; only the map tile background needs network.
class PlacesImporter {
  PlacesImporter(this.store);

  final ContentStore store;

  static const String assetPath = 'assets/data/places.json';

  Future<int> _placeCount() async {
    final countExp = store.places.id.count();
    final query = store.selectOnly(store.places)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle() ?? 0;
  }

  /// Idempotent: loads places once, then no-ops on later calls.
  Future<void> ensureLoaded() async {
    if (await _placeCount() > 0) return;

    final raw = await rootBundle.loadString(assetPath);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final books = (data['books'] as List).cast<String>();
    final places = data['places'] as List;

    final placeRows = <PlacesCompanion>[];
    final verseRows = <PlaceVersesCompanion>[];
    var placeId = 0, verseRowId = 0;

    for (final p in places) {
      placeId++;
      placeRows.add(PlacesCompanion(
        id: Value(placeId),
        name: Value(p['n'] as String),
        lat: Value((p['lat'] as num).toDouble()),
        lng: Value((p['lng'] as num).toDouble()),
      ));
      for (final r in (p['r'] as List)) {
        verseRowId++;
        final ref = r as List;
        verseRows.add(PlaceVersesCompanion(
          id: Value(verseRowId),
          placeId: Value(placeId),
          bookName: Value(books[ref[0] as int]),
          chapter: Value(ref[1] as int),
          verse: Value(ref[2] as int),
        ));
      }
    }

    await store.batch((b) {
      b.insertAll(store.places, placeRows);
      b.insertAll(store.placeVerses, verseRows);
    });
  }
}
