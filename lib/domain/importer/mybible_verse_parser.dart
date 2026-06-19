import '../../data/models/verse_segment.dart';

class MyBibleVerseParser {
  bool _inItalic = false;
  bool _inJesusWords = false;
  bool _inStrongsNumber = false; // To hide standalone Strong's numbers
  
  List<VerseSegment> parseVerse(String text) {
    // Regex to match XML/HTML like tags. E.g. <pb/>, <t>, </i>, <S n="123">
    final regex = RegExp(r'<(/?[a-zA-Z0-9]+)([^>]*)>');
    final List<VerseSegment> segments = [];
    int lastMatchEnd = 0;
    
    // Replace standalone & with &amp; if needed, but since we just output text, 
    // we can ignore HTML entity decoding for now or do it if required.
    // MyBible often uses things like `<pb/>`
    
    for (final match in regex.allMatches(text)) {
      final textBefore = text.substring(lastMatchEnd, match.start);
      if (textBefore.isNotEmpty && !_inStrongsNumber) {
        segments.add(VerseSegment(
          text: _decodeEntities(textBefore),
          isItalic: _inItalic,
          isJesusWords: _inJesusWords,
        ));
      }
      
      final fullTag = match.group(1)!.toLowerCase();
      final attrsStr = match.group(2) ?? '';
      final isClosing = fullTag.startsWith('/');
      final isSelfClosing = attrsStr.endsWith('/');
      final tagName = isClosing ? fullTag.substring(1) : fullTag;
      
      if (tagName == 'pb') {
        segments.add(const VerseSegment(isParagraphBreak: true));
      } else if (tagName == 'br') {
        segments.add(const VerseSegment(isLineBreak: true));
      } else if (tagName == 'i') {
        if (!isSelfClosing) _inItalic = !isClosing;
      } else if (tagName == 't' || tagName == 'j') {
        if (!isSelfClosing) _inJesusWords = !isClosing;
      } else if (tagName == 's') {
        if (!isClosing && !isSelfClosing) {
          if (attrsStr.toLowerCase().contains('n=')) {
            // safe
          } else {
            _inStrongsNumber = true;
          }
        } else if (isClosing) {
          _inStrongsNumber = false;
        }
      }
      
      lastMatchEnd = match.end;
    }
    
    final textAfter = text.substring(lastMatchEnd);
    if (textAfter.isNotEmpty && !_inStrongsNumber) {
      segments.add(VerseSegment(
        text: _decodeEntities(textAfter),
        isItalic: _inItalic,
        isJesusWords: _inJesusWords,
      ));
    }
    
    return segments;
  }
  
  String _decodeEntities(String input) {
    return input.replaceAll('&lt;', '<')
                .replaceAll('&gt;', '>')
                .replaceAll('&quot;', '"')
                .replaceAll('&apos;', "'")
                .replaceAll('&amp;', '&');
  }
}
