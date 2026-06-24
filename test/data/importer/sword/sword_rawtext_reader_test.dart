import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/sword_rawtext_reader.dart';

/// Little-endian byte helpers mirroring the on-disk `.vss` record fields.
Uint8List _le32(int v) =>
    (ByteData(4)..setUint32(0, v, Endian.little)).buffer.asUint8List();
Uint8List _le16(int v) =>
    (ByteData(2)..setUint16(0, v, Endian.little)).buffer.asUint8List();

Uint8List _concat(List<List<int>> parts) {
  final out = BytesBuilder();
  for (final p in parts) {
    out.add(p);
  }
  return out.toBytes();
}

/// A `.vss` record (`start, length`): 6 bytes (u16 length) or 8 bytes (u32
/// length) for RawText4.
Uint8List _vss(int start, int length, {bool r4 = false}) =>
    _concat([_le32(start), r4 ? _le32(length) : _le16(length)]);

void main() {
  group('SwordRawTextReader', () {
    const verseA = 'In the beginning — God';
    const verseB = 'created the heavens';
    final text = utf8.encode('$verseA$verseB');
    final lenA = utf8.encode(verseA).length;
    final lenB = utf8.encode(verseB).length;

    // Slot 0 is a zero-length heading; slots 1–2 are the two verses.
    final verseIndex = _concat([
      _vss(0, 0),
      _vss(0, lenA),
      _vss(lenA, lenB),
    ]);

    SwordRawTextReader reader() => SwordRawTextReader(
          verseIndex: verseIndex,
          textData: Uint8List.fromList(text),
        );

    test('decodes verses by slicing the flat text file', () {
      final r = reader();
      expect(r.recordCount, 3);
      expect(r.entryAt(1), verseA);
      expect(r.entryAt(2), verseB);
    });

    test('zero-length slot returns null', () {
      expect(reader().entryAt(0), isNull);
    });

    test('out-of-range slot returns null', () {
      final r = reader();
      expect(r.entryAt(3), isNull);
      expect(r.entryAt(-1), isNull);
    });

    test('throws on a slice that runs past the text file', () {
      final bad = SwordRawTextReader(
        verseIndex: _vss(0, text.length + 50),
        textData: Uint8List.fromList(text),
      );
      expect(() => bad.entryAt(0), throwsFormatException);
    });

    test('Latin-1 module decodes high bytes as Latin-1', () {
      final bytes = latin1.encode('café'); // é = 0xE9 as one byte
      final r = SwordRawTextReader(
        verseIndex: _vss(0, bytes.length),
        textData: Uint8List.fromList(bytes),
        isUtf8: false,
      );
      expect(r.entryAt(0), 'café');
    });

    test('RawText4 reads a u32 length field (8-byte records)', () {
      const t = 'four-byte length field';
      final bytes = utf8.encode(t);
      final r = SwordRawTextReader(
        verseIndex: _vss(0, bytes.length, r4: true),
        textData: Uint8List.fromList(bytes),
        isRawText4: true,
      );
      expect(r.recordCount, 1);
      expect(r.entryAt(0), t);
    });
  });
}
