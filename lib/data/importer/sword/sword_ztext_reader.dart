import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'sword_config.dart';
import 'sword_verse_reader.dart';

/// Reads raw entry text out of a SWORD compressed verse driver (`zText`/`zCom`)
/// for a single testament.
///
/// A testament is three files sharing a basename (`ot`/`nt`) and a block letter
/// derived from the module's `BlockType` (`b`=BOOK, `c`=CHAPTER, `v`=VERSE):
///
/// * `…zv` — **verse index**: one record per versification slot,
///   `block(u32) + offsetInBlock(u32) + length(u16)` little-endian (10 bytes;
///   for `zText4` the length is a u32, 12 bytes).
/// * `…zs` — **block index**: one record per compressed block,
///   `fileOffset(u32) + compressedSize(u32) + uncompressedSize(u32)` LE
///   (12 bytes).
/// * `…zz` — the concatenated compressed blocks.
///
/// To read slot N: verse-index[N] → `(block, offset, length)`; block-index
/// [block] → seek/decompress that block from the data file; slice
/// `[offset, offset+length)`; decode with the module encoding. The positional
/// slot N comes from the versification (see `sword_versification.dart`).
///
/// The core operates on in-memory buffers so it is unit-testable without files;
/// [SwordZTextReader.fromTestamentFiles] loads the three files from disk.
class SwordZTextReader implements SwordVerseReader {
  /// The `…zv` verse-index bytes.
  final Uint8List verseIndex;

  /// The `…zs` block-index bytes.
  final Uint8List blockIndex;

  /// The `…zz` compressed data bytes.
  final Uint8List textData;

  /// True for the `zText4`/`zCom4` drivers, whose verse-index length field is a
  /// u32 (12-byte records) rather than a u16 (10-byte records).
  final bool isZText4;

  /// Block compression. [SwordCompressType.zip] (zlib) and
  /// [SwordCompressType.bzip2] are implemented; the rest throw from
  /// [_decompressBlock] with a clear message.
  final SwordCompressType compressType;

  /// Whether to decode entry bytes as UTF-8 (else Latin-1).
  final bool isUtf8;

  // Single-block cache: SWORD groups many verses into one compressed block, so
  // sequential reads (the import walk) hit the same block repeatedly.
  int _cachedBlockNum = -1;
  Uint8List? _cachedBlock;

  SwordZTextReader({
    required this.verseIndex,
    required this.blockIndex,
    required this.textData,
    required this.compressType,
    this.isZText4 = false,
    this.isUtf8 = true,
  });

  int get _verseRecordSize => isZText4 ? 12 : 10;

  /// Number of verse-index slots available.
  @override
  int get recordCount => verseIndex.length ~/ _verseRecordSize;

  /// The decoded entry text at testament-relative [index], or null when the
  /// slot is out of range or has zero length (a verse not present in this
  /// module — common for headings and gaps in the versification).
  @override
  String? entryAt(int index) {
    if (index < 0) return null;
    final pos = index * _verseRecordSize;
    if (pos + _verseRecordSize > verseIndex.length) return null;

    final v = ByteData.sublistView(verseIndex, pos, pos + _verseRecordSize);
    final blockNum = v.getUint32(0, Endian.little);
    final offset = v.getUint32(4, Endian.little);
    final length =
        isZText4 ? v.getUint32(8, Endian.little) : v.getUint16(8, Endian.little);
    if (length == 0) return null;

    final block = _block(blockNum);
    final end = offset + length;
    if (offset > block.length || end > block.length) {
      throw FormatException(
        'SWORD verse slot $index points past block $blockNum '
        '($offset+$length > ${block.length}); module may be corrupt.',
      );
    }
    final bytes = Uint8List.sublistView(block, offset, end);
    return isUtf8
        ? utf8.decode(bytes, allowMalformed: true)
        : latin1.decode(bytes, allowInvalid: true);
  }

  /// Decompress (and cache) block [blockNum] from the data file.
  Uint8List _block(int blockNum) {
    if (blockNum == _cachedBlockNum && _cachedBlock != null) {
      return _cachedBlock!;
    }
    final pos = blockNum * 12;
    if (pos < 0 || pos + 12 > blockIndex.length) {
      throw FormatException(
        'SWORD block index $blockNum out of range; module may be corrupt.',
      );
    }
    final b = ByteData.sublistView(blockIndex, pos, pos + 12);
    final fileOffset = b.getUint32(0, Endian.little);
    final compSize = b.getUint32(4, Endian.little);
    // Field 8 (uncompressed size) is advisory; we trust the decoder's output.

    if (fileOffset + compSize > textData.length) {
      throw FormatException(
        'SWORD block $blockNum extends past data file; module may be corrupt.',
      );
    }
    final compressed =
        Uint8List.sublistView(textData, fileOffset, fileOffset + compSize);
    final out = _decompressBlock(compressed);

    _cachedBlockNum = blockNum;
    _cachedBlock = out;
    return out;
  }

  Uint8List _decompressBlock(Uint8List compressed) {
    switch (compressType) {
      case SwordCompressType.zip:
        // SWORD's ZIP driver writes zlib-wrapped streams (zlib.compress), so
        // decode with the zlib codec rather than raw inflate.
        return Uint8List.fromList(zlib.decode(compressed));
      case SwordCompressType.bzip2:
        return BZip2Decoder().decodeBytes(compressed);
      case SwordCompressType.lzss:
      case SwordCompressType.xz:
        throw UnsupportedError(
          'SWORD ${compressType.name.toUpperCase()} compression is not yet '
          'supported; only ZIP (zlib) and BZIP2 modules can be imported.',
        );
    }
  }

  /// Load the three testament files from [dataDir] for [testament] (`ot`/`nt`),
  /// choosing file extensions from [config] (`BlockType`, `ModDrv`) and
  /// returning null if the testament's files are absent (e.g. an NT-only
  /// module has no `ot.*`).
  static Future<SwordZTextReader?> fromTestamentFiles(
    Directory dataDir,
    String testament,
    SwordConfig config,
  ) async {
    final blockLetter = switch (config.blockType) {
      'CHAPTER' => 'c',
      'VERSE' => 'v',
      _ => 'b', // BOOK is the default and most common
    };
    final compressType = config.compressType ?? SwordCompressType.zip;
    final isZText4 =
        config.modDrv == SwordModDrv.zText4 || config.modDrv == SwordModDrv.zCom4;

    File f(String suffix) =>
        File('${dataDir.path}/$testament.${blockLetter}z$suffix');

    final verseFile = f('v');
    final blockFile = f('s');
    final dataFile = f('z');
    if (!await verseFile.exists() ||
        !await blockFile.exists() ||
        !await dataFile.exists()) {
      return null;
    }

    return SwordZTextReader(
      verseIndex: await verseFile.readAsBytes(),
      blockIndex: await blockFile.readAsBytes(),
      textData: await dataFile.readAsBytes(),
      compressType: compressType,
      isZText4: isZText4,
      isUtf8: config.isUtf8,
    );
  }
}
