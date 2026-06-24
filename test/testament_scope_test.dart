import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/domain/search/testament_scope.dart';

void main() {
  group('parseTestamentScope', () {
    test('no prefix leaves the query untouched', () {
      final r = parseTestamentScope('  love your enemies  ');
      expect(r.testament, isNull);
      expect(r.terms, 'love your enemies');
    });

    test('ot: / nt: prefixes set the testament', () {
      expect(parseTestamentScope('ot: covenant').testament, 'OT');
      expect(parseTestamentScope('nt: grace').testament, 'NT');
    });

    test('prefix is case-insensitive and the terms are stripped', () {
      final r = parseTestamentScope('NT: the Word');
      expect(r.testament, 'NT');
      expect(r.terms, 'the Word');
    });

    test('works with or without a space after the colon', () {
      expect(parseTestamentScope('ot:love').terms, 'love');
      expect(parseTestamentScope('ot:   love').terms, 'love');
    });

    test('tolerates leading whitespace before the prefix', () {
      final r = parseTestamentScope('   nt: faith');
      expect(r.testament, 'NT');
      expect(r.terms, 'faith');
    });

    test('a bare prefix yields empty terms', () {
      final r = parseTestamentScope('ot:');
      expect(r.testament, 'OT');
      expect(r.terms, '');
    });

    test('the word "ot"/"nt" without a colon is a normal search', () {
      final r = parseTestamentScope('ot test');
      expect(r.testament, isNull);
      expect(r.terms, 'ot test');
    });

    test('a word that merely starts with ot/nt is not a prefix', () {
      final r = parseTestamentScope('nthings');
      expect(r.testament, isNull);
      expect(r.terms, 'nthings');
    });
  });
}
