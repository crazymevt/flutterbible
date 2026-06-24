import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/tei_fragment_parser.dart';

void main() {
  group('parseTeiFragment', () {
    test('keeps the headword and breaks before the definition body', () {
      final r = parseTeiFragment(
          '<entryFree><title>Aaron</title><p>The brother of Moses.</p></entryFree>');
      expect(r.text, 'Aaron The brother of Moses.');
      expect(r.segments.any((s) => s.isLineBreak), isTrue);
      expect(r.segments.any((s) => s.isParagraphBreak), isTrue);
    });

    test('flattens refs and marks foreign/hi italic, drops notes', () {
      final r = parseTeiFragment(
          'See <ref osisRef="Bible:Gen.1.1">Gen 1:1</ref> and '
          '<foreign>eretz</foreign><hi rend="italic">land</hi>'
          '<note>a footnote</note>');
      expect(r.text, contains('Gen 1:1'));
      expect(r.text, isNot(contains('footnote')));
      expect(r.segments.firstWhere((s) => s.text.trim() == 'eretz').isItalic,
          isTrue);
      expect(r.segments.firstWhere((s) => s.text.trim() == 'land').isItalic,
          isTrue);
      expect(r.segments.singleWhere((s) => s.isFootnote).footnoteText,
          'a footnote');
    });

    test('falls back to tag-stripping on malformed XML', () {
      final r = parseTeiFragment('Tom & Jerry <orth>X');
      expect(r.text, 'Tom & Jerry X');
    });
  });
}
