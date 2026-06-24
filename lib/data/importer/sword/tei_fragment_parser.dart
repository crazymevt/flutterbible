import 'package:xml/xml.dart';

import 'parsed_verse_entry.dart';
import 'verse_segment_builder.dart';

/// Parses a single **TEI** (Text Encoding Initiative) fragment — the markup
/// SWORD uses for most dictionaries/lexicons (`zLD`/`RawLD`) — into plain text
/// plus segments, mirroring the other per-source filters.
///
/// TEI is XML, so the fragment is wrapped and parsed as a tree. The elements
/// handled here cover the common dictionary vocabulary:
///
/// * `<entryFree>`/`<entry>` — the entry container (recurse).
/// * `<title>`/`<orth>` — the headword/heading; kept, followed by a line break.
/// * `<p>` — paragraph break; `<lb/>` — line break.
/// * `<hi>` (`rend="italic"`), `<foreign>`, `<emph>`, `<mentioned>` — italic.
/// * `<note>` — a footnote, kept out of the plain text.
/// * `<ref>`/`<reg>`/`<pron>`/`<def>`/`<sense>`/`<cit>`/… — flattened to text.
///
/// Falls back to crude tag-stripping if the fragment is not well-formed XML.
ParsedVerseEntry parseTeiFragment(String fragment) {
  final b = VerseSegmentBuilder();

  void walk(XmlNode node, {required bool italic}) {
    for (final child in node.children) {
      if (child is XmlText) {
        b.addText(child.value, italic: italic);
        continue;
      }
      if (child is! XmlElement) continue;

      switch (child.localName.toLowerCase()) {
        case 'note':
          b.addFootnote(child.innerText);
          continue; // don't recurse — note content isn't definition text
        case 'lb':
          b.addLineBreak();
          continue;
        case 'p':
          b.addParagraphBreak();
          walk(child, italic: italic);
          continue;
        case 'title':
        case 'orth':
          // Headword/heading: keep the text, then break so it doesn't run into
          // the definition body.
          walk(child, italic: italic);
          b.addLineBreak();
          continue;
        case 'hi':
          final rend = child.getAttribute('rend')?.toLowerCase();
          walk(child, italic: italic || rend == 'italic' || rend == 'ital');
          continue;
        case 'foreign':
        case 'emph':
        case 'mentioned':
          walk(child, italic: true);
          continue;
        default:
          // ref, reg, pron, def, sense, cit, gramGrp, etc.: flatten their text.
          walk(child, italic: italic);
      }
    }
  }

  XmlElement root;
  try {
    root = XmlDocument.parse('<teiFragment>$fragment</teiFragment>').rootElement;
  } catch (_) {
    final stripped = fragment
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (stripped.isNotEmpty) b.addText(stripped);
    return b.build();
  }

  walk(root, italic: false);
  return b.build();
}
