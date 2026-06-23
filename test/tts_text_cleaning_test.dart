import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/mybible_verse_parser.dart';

/// Guards the contract the TTS read-aloud relies on: verse `textContent` carries
/// inline MyBible markup (Strong's tags etc.), which must be stripped before the
/// text is spoken, or the engine reads the tag numbers aloud.
String cleanForSpeech(String raw) => MyBibleVerseParser()
    .parseVerse(raw)
    .map((s) => s.text)
    .join('')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

void main() {
  test('strips Strong\'s number tags from verse text', () {
    const raw =
        'In the beginning<S>7225</S> God<S>430</S> created<S>1254</S> <S>853</S> the heaven<S>8064</S> and<S>853</S> the earth<S>776</S>.';
    expect(cleanForSpeech(raw),
        'In the beginning God created the heaven and the earth.');
  });

  test('leaves plain text untouched', () {
    expect(cleanForSpeech('Jesus wept.'), 'Jesus wept.');
  });

  test('produces no angle-bracket markup', () {
    const raw = 'For God<S>2316</S> so loved<S>25</S> the world<S>2889</S>';
    expect(cleanForSpeech(raw), isNot(contains('<')));
    expect(cleanForSpeech(raw), isNot(contains('7225')));
  });
}
