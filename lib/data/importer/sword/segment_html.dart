import '../../models/verse_segment.dart';

/// Serialise parsed [VerseSegment]s into simple, safe HTML for the commentary
/// and dictionary panels (both render with `HtmlWidget`).
///
/// Paragraph-break segments split the output into `<p>` blocks; line breaks
/// become `<br>`; italic/added words become `<i>`; words of Jesus get a red
/// span; footnotes render inline in brackets. Strong's numbers are dropped —
/// they are noise in prose commentary/definition display. All text is
/// HTML-escaped so source markup can never leak into the rendered output.
String segmentsToHtml(List<VerseSegment> segments) {
  final out = StringBuffer();
  final para = StringBuffer();

  void flushPara() {
    final s = para.toString().trim();
    if (s.isNotEmpty) out.write('<p>$s</p>');
    para.clear();
  }

  for (final seg in segments) {
    if (seg.isParagraphBreak) {
      flushPara();
      continue;
    }
    if (seg.isLineBreak) {
      para.write('<br>');
      continue;
    }
    if (seg.isFootnote) {
      final t = seg.footnoteText ?? '';
      if (t.isNotEmpty) {
        para.write('<span class="note">[${_escape(t)}]</span>');
      }
      continue;
    }
    var text = _escape(seg.text);
    if (seg.isItalic) text = '<i>$text</i>';
    if (seg.isJesusWords) text = '<span style="color:#c00">$text</span>';
    para.write(text);
  }
  flushPara();
  return out.toString();
}

String _escape(String s) => s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;');
