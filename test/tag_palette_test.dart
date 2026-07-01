import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/ui/tags/tag_palette.dart';

void main() {
  group('tagColorFromHex', () {
    test('parses #RRGGBB and bare RRGGBB as opaque colours', () {
      expect(tagColorFromHex('#E53935'), const Color(0xFFE53935));
      expect(tagColorFromHex('E53935'), const Color(0xFFE53935));
    });

    test('honours an explicit alpha channel', () {
      expect(tagColorFromHex('80E53935'), const Color(0x80E53935));
    });

    test('returns null for null, empty, or malformed input', () {
      expect(tagColorFromHex(null), isNull);
      expect(tagColorFromHex(''), isNull);
      expect(tagColorFromHex('nope'), isNull);
      expect(tagColorFromHex('#12345'), isNull);
    });
  });

  group('normalizeTagHex', () {
    test('canonicalises spelling so equal colours compare equal', () {
      expect(normalizeTagHex('e53935'), '#E53935');
      expect(normalizeTagHex('#E53935'), '#E53935');
      expect(normalizeTagHex('  #e53935 '), '#E53935');
    });

    test('returns null for null/empty/malformed input', () {
      expect(normalizeTagHex(null), isNull);
      expect(normalizeTagHex(''), isNull);
      expect(normalizeTagHex('zzzzzz'), isNull);
    });
  });

  test('every palette swatch has a parseable, canonical hex', () {
    for (final s in kTagPalette) {
      expect(tagColorFromHex(s.hex), isNotNull, reason: '${s.name} unparseable');
      expect(normalizeTagHex(s.hex), s.hex,
          reason: '${s.name} hex is not already canonical');
    }
  });
}
