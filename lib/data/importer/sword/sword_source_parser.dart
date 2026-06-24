import '../../models/verse_segment.dart';
import 'gbf_fragment_parser.dart';
import 'osis_fragment_parser.dart';
import 'parsed_verse_entry.dart';
import 'sword_config.dart';
import 'tei_fragment_parser.dart';
import 'thml_fragment_parser.dart';

/// Parse a single SWORD entry's raw text according to its module [sourceType],
/// dispatching to the matching per-source filter. Shared by the Bible,
/// commentary, and dictionary importers so every content type flattens the same
/// markup the same way.
ParsedVerseEntry parseSwordSource(String raw, SwordSourceType sourceType) {
  switch (sourceType) {
    case SwordSourceType.osis:
      return parseOsisFragment(raw);
    case SwordSourceType.gbf:
      return parseGbfFragment(raw);
    case SwordSourceType.thml:
      return parseThmlFragment(raw);
    case SwordSourceType.tei:
      return parseTeiFragment(raw);
    case SwordSourceType.plaintext:
      return parsePlaintextEntry(raw);
  }
}

/// Treat a plaintext entry literally: collapse whitespace, single segment.
ParsedVerseEntry parsePlaintextEntry(String raw) {
  final text = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  return ParsedVerseEntry(
      text, text.isEmpty ? const [] : [VerseSegment(text: text)]);
}
