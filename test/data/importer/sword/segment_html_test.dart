import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/segment_html.dart';
import 'package:study_bible/data/models/verse_segment.dart';

void main() {
  group('segmentsToHtml', () {
    test('wraps text in a paragraph and escapes HTML', () {
      final html = segmentsToHtml([const VerseSegment(text: 'a < b & c')]);
      expect(html, '<p>a &lt; b &amp; c</p>');
    });

    test('splits paragraphs on paragraph breaks', () {
      final html = segmentsToHtml(const [
        VerseSegment(text: 'one'),
        VerseSegment(isParagraphBreak: true),
        VerseSegment(text: 'two'),
      ]);
      expect(html, '<p>one</p><p>two</p>');
    });

    test('renders line breaks, italic, and inline footnotes', () {
      final html = segmentsToHtml(const [
        VerseSegment(text: 'plain '),
        VerseSegment(text: 'added', isItalic: true),
        VerseSegment(isLineBreak: true),
        VerseSegment(text: 'next'),
        VerseSegment(isFootnote: true, footnoteText: 'see Gen 1'),
      ]);
      expect(html,
          '<p>plain <i>added</i><br>next<span class="note">[see Gen 1]</span></p>');
    });

    test('drops Strong\'s numbers from display text', () {
      final html =
          segmentsToHtml([const VerseSegment(text: 'God', strongs: 'H430')]);
      expect(html, '<p>God</p>');
    });

    test('produces nothing for empty/whitespace-only segments', () {
      expect(segmentsToHtml(const []), '');
      expect(segmentsToHtml(const [VerseSegment(isParagraphBreak: true)]), '');
    });
  });
}
