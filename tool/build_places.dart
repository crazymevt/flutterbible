// Build-time converter: OpenBible.info geocoding -> assets/data/places.json
//
// Source data: https://github.com/openbibleinfo/Bible-Geocoding-Data
// (data/ancient.jsonl + data/modern.jsonl), CC-BY 4.0.
//
// Usage:
//   dart run tool/build_places.dart <ancient.jsonl> <modern.jsonl> [out.json]
//
// For each ancient place we emit a representative coordinate (the highest-score
// modern identification's lon/lat) and the verses that mention it (decoded from
// the verse `sort` field, which encodes book*1e6 + chapter*1e3 + verse with the
// standard 1-based Protestant book order).
//
// Output shape:
//   { "books": [ "Genesis", ... 66 ... ],
//     "places": [ { "n": "Abana", "lat": 33.51, "lng": 36.30,
//                   "r": [ [bookIndex0Based, chapter, verse], ... ] } ] }

import 'dart:convert';
import 'dart:io';

const List<String> kBooks = [
  'Genesis', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy', 'Joshua',
  'Judges', 'Ruth', '1 Samuel', '2 Samuel', '1 Kings', '2 Kings',
  '1 Chronicles', '2 Chronicles', 'Ezra', 'Nehemiah', 'Esther', 'Job',
  'Psalms', 'Proverbs', 'Ecclesiastes', 'Song of Solomon', 'Isaiah',
  'Jeremiah', 'Lamentations', 'Ezekiel', 'Daniel', 'Hosea', 'Joel', 'Amos',
  'Obadiah', 'Jonah', 'Micah', 'Nahum', 'Habakkuk', 'Zephaniah', 'Haggai',
  'Zechariah', 'Malachi', 'Matthew', 'Mark', 'Luke', 'John', 'Acts',
  'Romans', '1 Corinthians', '2 Corinthians', 'Galatians', 'Ephesians',
  'Philippians', 'Colossians', '1 Thessalonians', '2 Thessalonians',
  '1 Timothy', '2 Timothy', 'Titus', 'Philemon', 'Hebrews', 'James',
  '1 Peter', '2 Peter', '1 John', '2 John', '3 John', 'Jude', 'Revelation',
];

void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln(
        'Usage: dart run tool/build_places.dart <ancient.jsonl> <modern.jsonl> [out.json]');
    exit(64);
  }
  final ancientPath = args[0];
  final modernPath = args[1];
  final outputPath = args.length > 2 ? args[2] : 'assets/data/places.json';

  // Modern place id -> [lng, lat].
  final modernCoord = <String, List<double>>{};
  for (final line in File(modernPath).readAsLinesSync()) {
    if (line.trim().isEmpty) continue;
    final m = jsonDecode(line) as Map<String, dynamic>;
    final id = m['id'] as String?;
    final lonlat = m['lonlat'] as String?;
    if (id == null || lonlat == null) continue;
    final parts = lonlat.split(',');
    if (parts.length != 2) continue;
    final lng = double.tryParse(parts[0].trim());
    final lat = double.tryParse(parts[1].trim());
    if (lng == null || lat == null) continue;
    modernCoord[id] = [lng, lat];
  }

  final places = <Map<String, dynamic>>[];
  var totalRefs = 0;
  var skippedNoCoord = 0;
  var skippedNoVerses = 0;

  for (final line in File(ancientPath).readAsLinesSync()) {
    if (line.trim().isEmpty) continue;
    final a = jsonDecode(line) as Map<String, dynamic>;
    final name = a['friendly_id'] as String?;
    if (name == null) continue;

    // Best-guess coordinate: highest-score modern association that has coords.
    final assoc = (a['modern_associations'] as Map<String, dynamic>?) ?? {};
    List<double>? coord;
    num bestScore = -1;
    assoc.forEach((modernId, info) {
      final score = (info is Map && info['score'] is num) ? info['score'] as num : 0;
      if (score > bestScore && modernCoord.containsKey(modernId)) {
        bestScore = score;
        coord = modernCoord[modernId];
      }
    });
    if (coord == null) {
      skippedNoCoord++;
      continue;
    }

    // Verse refs from the `sort` field: book*1e6 + chapter*1e3 + verse.
    final verses = (a['verses'] as List?) ?? [];
    final refs = <List<int>>[];
    final seen = <int>{};
    for (final v in verses) {
      final sortStr = (v as Map)['sort'];
      final sort = sortStr is String ? int.tryParse(sortStr) : (sortStr as int?);
      if (sort == null || !seen.add(sort)) continue;
      final book1 = sort ~/ 1000000;
      final chapter = (sort ~/ 1000) % 1000;
      final verse = sort % 1000;
      if (book1 < 1 || book1 > 66 || chapter < 1 || verse < 1) continue;
      refs.add([book1 - 1, chapter, verse]);
    }
    if (refs.isEmpty) {
      skippedNoVerses++;
      continue;
    }

    totalRefs += refs.length;
    places.add({
      'n': name,
      'lat': double.parse(coord![1].toStringAsFixed(5)),
      'lng': double.parse(coord![0].toStringAsFixed(5)),
      'r': refs,
    });
  }

  places.sort((a, b) => (a['n'] as String).compareTo(b['n'] as String));

  final out = {'books': kBooks, 'places': places};
  final outFile = File(outputPath);
  outFile.parent.createSync(recursive: true);
  outFile.writeAsStringSync(jsonEncode(out));

  stderr.writeln('Places: ${places.length}');
  stderr.writeln('Total place-verse refs: $totalRefs');
  stderr.writeln('Skipped (no coord): $skippedNoCoord, (no verses): $skippedNoVerses');
  stderr.writeln(
      'Output: $outputPath (${(outFile.lengthSync() / 1024).toStringAsFixed(0)} KB)');
}
