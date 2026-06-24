import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/sword_config.dart';
import 'package:study_bible/data/importer/sword/sword_ztext_reader.dart';

/// Little-endian byte helpers mirroring the on-disk record fields.
Uint8List _le32(int v) {
  final b = ByteData(4)..setUint32(0, v, Endian.little);
  return b.buffer.asUint8List();
}

Uint8List _le16(int v) {
  final b = ByteData(2)..setUint16(0, v, Endian.little);
  return b.buffer.asUint8List();
}

Uint8List _concat(List<List<int>> parts) {
  final out = BytesBuilder();
  for (final p in parts) {
    out.add(p);
  }
  return out.toBytes();
}

/// Build a verse-index record (`block, offset, length`), 10 bytes (u16 length)
/// or 12 bytes (u32 length) for zText4.
Uint8List _verseRec(int block, int offset, int length, {bool z4 = false}) =>
    _concat([_le32(block), _le32(offset), z4 ? _le32(length) : _le16(length)]);

/// Build a block-index record (`fileOffset, compSize, uncompSize`), 12 bytes.
Uint8List _blockRec(int fileOffset, int compSize, int uncompSize) =>
    _concat([_le32(fileOffset), _le32(compSize), _le32(uncompSize)]);

void main() {
  group('SwordZTextReader (zlib)', () {
    // Two compressed blocks. Block 0 holds verses A and B back-to-back; block 1
    // holds verse C. (A includes a non-ASCII char to exercise UTF-8 decoding.)
    const verseA = 'In the beginning — God';
    const verseB = 'created the heavens';
    const verseC = 'and the earth';
    final block0 = utf8.encode('$verseA$verseB');
    final block1 = utf8.encode(verseC);
    final comp0 = zlib.encode(block0);
    final comp1 = zlib.encode(block1);

    final textData = _concat([comp0, comp1]);
    final blockIndex = _concat([
      _blockRec(0, comp0.length, block0.length),
      _blockRec(comp0.length, comp1.length, block1.length),
    ]);
    // Slot 0 is a zero-length heading; slots 1–3 are the three verses.
    final offsetB = utf8.encode(verseA).length;
    final verseIndex = _concat([
      _verseRec(0, 0, 0),
      _verseRec(0, 0, utf8.encode(verseA).length),
      _verseRec(0, offsetB, utf8.encode(verseB).length),
      _verseRec(1, 0, utf8.encode(verseC).length),
    ]);

    SwordZTextReader reader() => SwordZTextReader(
          verseIndex: verseIndex,
          blockIndex: blockIndex,
          textData: textData,
          compressType: SwordCompressType.zip,
        );

    test('decodes verses, slicing within and across blocks', () {
      final r = reader();
      expect(r.recordCount, 4);
      expect(r.entryAt(1), verseA);
      expect(r.entryAt(2), verseB); // same block, second slice
      expect(r.entryAt(3), verseC); // different block
    });

    test('zero-length slot (heading/absent verse) returns null', () {
      expect(reader().entryAt(0), isNull);
    });

    test('out-of-range slot returns null', () {
      final r = reader();
      expect(r.entryAt(4), isNull);
      expect(r.entryAt(-1), isNull);
    });

    test('block cache survives re-reading an earlier block', () {
      final r = reader();
      expect(r.entryAt(1), verseA); // caches block 0
      expect(r.entryAt(3), verseC); // swaps to block 1
      expect(r.entryAt(2), verseB); // re-fetches block 0 correctly
    });

    test('throws on a slice that runs past the block', () {
      final bad = SwordZTextReader(
        verseIndex: _verseRec(0, 0, block0.length + 50),
        blockIndex: blockIndex,
        textData: textData,
        compressType: SwordCompressType.zip,
      );
      expect(() => bad.entryAt(0), throwsFormatException);
    });

    test('throws on a block index that points past the data file', () {
      final bad = SwordZTextReader(
        verseIndex: _verseRec(5, 0, 4), // block 5 doesn't exist
        blockIndex: blockIndex,
        textData: textData,
        compressType: SwordCompressType.zip,
      );
      expect(() => bad.entryAt(0), throwsFormatException);
    });
  });

  test('Latin-1 module decodes high bytes as Latin-1', () {
    final block = latin1.encode('café'); // é = 0xE9 as one byte
    final comp = zlib.encode(block);
    final r = SwordZTextReader(
      verseIndex: _verseRec(0, 0, block.length),
      blockIndex: _blockRec(0, comp.length, block.length),
      textData: Uint8List.fromList(comp),
      compressType: SwordCompressType.zip,
      isUtf8: false,
    );
    expect(r.entryAt(0), 'café');
  });

  test('zText4 reads a u32 length field (12-byte verse records)', () {
    const text = 'four-byte length field';
    final block = utf8.encode(text);
    final comp = zlib.encode(block);
    final r = SwordZTextReader(
      verseIndex: _verseRec(0, 0, block.length, z4: true),
      blockIndex: _blockRec(0, comp.length, block.length),
      textData: Uint8List.fromList(comp),
      compressType: SwordCompressType.zip,
      isZText4: true,
    );
    expect(r.recordCount, 1);
    expect(r.entryAt(0), text);
  });

  test('BZIP2 module decodes blocks via the bzip2 codec', () {
    const verseA = 'In the beginning — God';
    const verseB = 'created the heavens';
    final block = utf8.encode('$verseA$verseB');
    final comp = BZip2Encoder().encode(block);
    final offsetB = utf8.encode(verseA).length;
    final r = SwordZTextReader(
      verseIndex: _concat([
        _verseRec(0, 0, utf8.encode(verseA).length),
        _verseRec(0, offsetB, utf8.encode(verseB).length),
      ]),
      blockIndex: _blockRec(0, comp.length, block.length),
      textData: Uint8List.fromList(comp),
      compressType: SwordCompressType.bzip2,
    );
    expect(r.entryAt(0), verseA);
    expect(r.entryAt(1), verseB); // second slice from the same decoded block
  });

  test('unsupported compression throws a clear error', () {
    final r = SwordZTextReader(
      verseIndex: _verseRec(0, 0, 4),
      blockIndex: _blockRec(0, 4, 4),
      textData: Uint8List.fromList([0, 0, 0, 0]),
      compressType: SwordCompressType.lzss,
    );
    expect(() => r.entryAt(0), throwsUnsupportedError);
  });
}
