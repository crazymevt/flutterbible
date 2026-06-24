import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'sword_config.dart';
import 'sword_verse_reader.dart';

/// Reads raw entry text out of a SWORD *uncompressed* verse driver
/// (`RawText`/`RawText4`) for a single testament.
///
/// Unlike the compressed `zText` layout there is no block layer: a testament is
/// two files sharing a basename (`ot`/`nt`):
///
/// * `ot` — the concatenated verse text, stored uncompressed.
/// * `ot.vss` — the **verse index**: one record per versification slot,
///   `start(u32) + length(u16)` little-endian (6 bytes; for `RawText4` the
///   length is a u32, 8 bytes).
///
/// To read slot N: verse-index[N] → `(start, length)`; slice
/// `[start, start+length)` from the text file; decode with the module encoding.
/// The positional slot N comes from the versification (see
/// `sword_versification.dart`) — identical semantics to [SwordZTextReader],
/// including the reserved leading heading slots.
class SwordRawTextReader implements SwordVerseReader {
  /// The `…vss` verse-index bytes.
  final Uint8List verseIndex;

  /// The concatenated (uncompressed) testament text bytes.
  final Uint8List textData;

  /// True for the `RawText4` driver, whose verse-index length field is a u32
  /// (8-byte records) rather than a u16 (6-byte records).
  final bool isRawText4;

  /// Whether to decode entry bytes as UTF-8 (else Latin-1).
  final bool isUtf8;

  SwordRawTextReader({
    required this.verseIndex,
    required this.textData,
    this.isRawText4 = false,
    this.isUtf8 = true,
  });

  int get _recordSize => isRawText4 ? 8 : 6;

  @override
  int get recordCount => verseIndex.length ~/ _recordSize;

  @override
  String? entryAt(int index) {
    if (index < 0) return null;
    final pos = index * _recordSize;
    if (pos + _recordSize > verseIndex.length) return null;

    final v = ByteData.sublistView(verseIndex, pos, pos + _recordSize);
    final start = v.getUint32(0, Endian.little);
    final length = isRawText4
        ? v.getUint32(4, Endian.little)
        : v.getUint16(4, Endian.little);
    if (length == 0) return null;

    final end = start + length;
    if (start > textData.length || end > textData.length) {
      throw FormatException(
        'SWORD verse slot $index points past the text file '
        '($start+$length > ${textData.length}); module may be corrupt.',
      );
    }
    final bytes = Uint8List.sublistView(textData, start, end);
    return isUtf8
        ? utf8.decode(bytes, allowMalformed: true)
        : latin1.decode(bytes, allowInvalid: true);
  }

  /// Load the two testament files from [dataDir] for [testament] (`ot`/`nt`),
  /// returning null if either is absent (e.g. an NT-only module has no `ot`).
  static Future<SwordRawTextReader?> fromTestamentFiles(
    Directory dataDir,
    String testament,
    SwordConfig config,
  ) async {
    final textFile = File('${dataDir.path}/$testament');
    final indexFile = File('${dataDir.path}/$testament.vss');
    if (!await textFile.exists() || !await indexFile.exists()) {
      return null;
    }
    return SwordRawTextReader(
      verseIndex: await indexFile.readAsBytes(),
      textData: await textFile.readAsBytes(),
      isRawText4: config.modDrv == SwordModDrv.rawText4,
      isUtf8: config.isUtf8,
    );
  }
}
