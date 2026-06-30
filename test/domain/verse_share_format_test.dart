import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/domain/scripture/verse_share_format.dart';

void main() {
  group('VerseShareFormatter.formatVerseRange', () {
    test('collapses contiguous runs into ranges', () {
      expect(VerseShareFormatter.formatVerseRange([1, 2, 3, 5]), '1-3, 5');
    });

    test('handles single verses and gaps', () {
      expect(VerseShareFormatter.formatVerseRange([16]), '16');
      expect(VerseShareFormatter.formatVerseRange([16, 18]), '16, 18');
    });

    test('sorts before collapsing', () {
      expect(VerseShareFormatter.formatVerseRange([3, 1, 2]), '1-3');
    });

    test('empty list yields empty string', () {
      expect(VerseShareFormatter.formatVerseRange([]), '');
    });
  });

  group('VerseShareFormatter.reference', () {
    test('omits the version when none supplied', () {
      expect(
        VerseShareFormatter.reference(
          bookName: 'John',
          chapter: 3,
          verseNumbers: [16, 17],
        ),
        'John 3:16-17',
      );
    });

    test('appends the version abbreviation when supplied', () {
      expect(
        VerseShareFormatter.reference(
          bookName: 'John',
          chapter: 3,
          verseNumbers: [16],
          versionAbbreviation: 'ESV',
        ),
        'John 3:16 (ESV)',
      );
    });
  });

  group('VerseShareFormatter.format', () {
    const verses = <ShareVerse>[
      (number: 16, text: 'For God so loved the world.'),
      (number: 17, text: 'For God sent not his Son to condemn.'),
    ];

    test('default: reference on top, numbered lines', () {
      final out = VerseShareFormatter.format(
        bookName: 'John',
        chapter: 3,
        verses: verses,
      );
      expect(
        out,
        'John 3:16-17\n'
        '16 For God so loved the world.\n'
        '17 For God sent not his Son to condemn.',
      );
    });

    test('bottom citation, no numbers: flows into a quotable paragraph', () {
      final out = VerseShareFormatter.format(
        bookName: 'John',
        chapter: 3,
        verses: verses,
        versionAbbreviation: 'KJV',
        format: const VerseShareFormat(
          includeVerseNumbers: false,
          includeVersionAbbreviation: true,
          referencePosition: VerseReferencePosition.bottom,
        ),
      );
      expect(
        out,
        'For God so loved the world. For God sent not his Son to condemn.\n'
        '— John 3:16-17 (KJV)',
      );
    });

    test('version abbreviation is suppressed unless opted in', () {
      final out = VerseShareFormatter.format(
        bookName: 'John',
        chapter: 3,
        verses: [verses.first],
        versionAbbreviation: 'ESV',
      );
      expect(out, 'John 3:16\n16 For God so loved the world.');
    });

    test('sorts verses before rendering', () {
      final out = VerseShareFormatter.format(
        bookName: 'John',
        chapter: 3,
        verses: [verses[1], verses[0]],
      );
      expect(out.startsWith('John 3:16-17\n16 '), isTrue);
    });

    test('empty selection yields empty string', () {
      expect(
        VerseShareFormatter.format(bookName: 'John', chapter: 3, verses: []),
        '',
      );
    });
  });

  test('VerseReferencePosition.fromName round-trips and defaults to top', () {
    expect(VerseReferencePosition.fromName('bottom'),
        VerseReferencePosition.bottom);
    expect(VerseReferencePosition.fromName('top'), VerseReferencePosition.top);
    expect(VerseReferencePosition.fromName(null), VerseReferencePosition.top);
    expect(VerseReferencePosition.fromName('garbage'),
        VerseReferencePosition.top);
  });
}
