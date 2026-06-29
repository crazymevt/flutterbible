import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/mybible_importer.dart';

void main() {
  group('renderMyBibleCrossRef', () {
    test('empty input yields empty output', () {
      expect(renderMyBibleCrossRef(''), '');
    });

    test('single cross-reference link keeps only the visible label', () {
      expect(
        renderMyBibleCrossRef("<a href='B:650 1:10'>HEB 1:10</a>"),
        'HEB 1:10',
      );
    });

    test('comma-joined references get a space after the comma', () {
      expect(
        renderMyBibleCrossRef(
          "<a href='B:500 1:1'>JHN 1:1</a>,<a href='B:500 1:3'>3</a>",
        ),
        'JHN 1:1, 3',
      );
    });

    test('semicolon-separated references are normalised', () {
      expect(
        renderMyBibleCrossRef(
          "<a href='B:730 4:11'>REV 4:11</a>; <a href='B:650 11:3'>HEB 11:3</a>; "
          "<a href='B:580 1:16'>COL 1:16</a>",
        ),
        'REV 4:11; HEB 11:3; COL 1:16',
      );
    });

    test('plain (untagged) text passes through, whitespace collapsed', () {
      expect(
        renderMyBibleCrossRef('see   also  Genesis 1'),
        'see also Genesis 1',
      );
    });
  });
}
