import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/domain/search/reference_parser.dart';

Book _book(int order, String name, String testament) => Book(
  id: order,
  versionId: 'KJV',
  name: name,
  bookOrder: order,
  testament: testament,
);

void main() {
  final books = [
    _book(1, 'Genesis', 'OT'),
    _book(19, 'Psalms', 'OT'),
    _book(27, 'Daniel', 'OT'),
    _book(43, 'John', 'NT'),
    _book(62, '1 John', 'NT'),
    _book(22, 'Song of Solomon', 'OT'),
  ];

  // findBook expects already-lowercased input (callers lowercase first).
  String? name(String input) => ReferenceParser.findBook(input, books)?.name;

  group('ReferenceParser.findBook', () {
    test('exact match', () {
      expect(name('john'), 'John');
      expect(name('daniel'), 'Daniel');
    });

    test('space-normalized match for multi-word / numbered books', () {
      expect(name('1 john'), '1 John');
      expect(name('1john'), '1 John');
      expect(name('songofsolomon'), 'Song of Solomon');
    });

    test('prefix match enables abbreviations', () {
      expect(name('ps'), 'Psalms');
      expect(name('dan'), 'Daniel');
    });

    test('a non-book word resolves to nothing', () {
      expect(name('love'), isNull);
      expect(name('xyz'), isNull);
    });
  });
}
