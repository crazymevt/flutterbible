import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'sword_config.dart';

/// A single dictionary/lexicon entry: its [key] (headword) and the raw [body]
/// markup (TEI/ThML/OSIS/plain, per the module's `SourceType`).
class SwordLdEntry {
  final String key;
  final String body;
  const SwordLdEntry(this.key, this.body);
}

/// Reads all entries out of a SWORD dictionary/lexicon module — both the
/// uncompressed `RawLD`/`RawLD4` and the compressed `zLD` key-based drivers.
///
/// Unlike Bibles/commentaries (positional verse index), dictionaries are keyed
/// by headword:
///
/// * **RawLD** — `<name>.idx` records `start(u32) + size(u16)` (or `u32` for
///   `RawLD4`) into `<name>.dat`, where each record is `KEY\r\n<body>`.
/// * **zLD** — `<name>.idx` records `start(u32) + size(u32)` into `<name>.dat`,
///   where each record is `KEY\r\n` + `blockNum(u32)` + `entryInBlock(u32)`.
///   The body lives in a compressed block: `<name>.zdx` records
///   `blockOffset(u32) + compSize(u32)` into `<name>.zdt`; each decompressed
///   block is `count(u32)` followed by `count` × `(offset(u32), size(u32))`
///   (absolute from block start) and then the entry bodies.
///
/// The `.idx` record stride (6 vs 8 bytes) is auto-detected by bounds-checking
/// against the `.dat` length, since RawLD uses a 16-bit size while zLD/RawLD4
/// use 32-bit.
class SwordLdReader {
  final List<SwordLdEntry> entries;
  SwordLdReader._(this.entries);

  /// Uncompressed `RawLD`/`RawLD4`: keys and bodies both live in `.dat`.
  factory SwordLdReader.raw({
    required Uint8List idx,
    required Uint8List dat,
    bool isUtf8 = true,
  }) {
    final stride = _detectStride(idx, dat.length);
    final out = <SwordLdEntry>[];
    final n = idx.length ~/ stride;
    for (var i = 0; i < n; i++) {
      final start = _u32(idx, i * stride);
      final size = stride == 8 ? _u32(idx, i * stride + 4) : _u16(idx, i * stride + 4);
      if (size == 0 || start + size > dat.length) continue;
      final rec = Uint8List.sublistView(dat, start, start + size);
      final nl = rec.indexOf(0x0a);
      if (nl < 0) continue;
      final key = _decode(Uint8List.sublistView(rec, 0, nl), isUtf8)
          .replaceAll('\r', '')
          .trim();
      if (key.isEmpty) continue;
      final body = _decode(Uint8List.sublistView(rec, nl + 1), isUtf8);
      out.add(SwordLdEntry(key, body));
    }
    return SwordLdReader._(out);
  }

  /// Compressed `zLD`: keys + block pointers in `.dat`/`.idx`, bodies in the
  /// `.zdt`/`.zdx` compressed blocks.
  factory SwordLdReader.compressed({
    required Uint8List idx,
    required Uint8List dat,
    required Uint8List zdx,
    required Uint8List zdt,
    SwordCompressType compressType = SwordCompressType.zip,
    bool isUtf8 = true,
  }) {
    final stride = _detectStride(idx, dat.length);
    final out = <SwordLdEntry>[];
    final n = idx.length ~/ stride;

    int cachedBlockNum = -1;
    Uint8List? cachedBlock;
    Uint8List blockFor(int bn) {
      if (bn == cachedBlockNum && cachedBlock != null) return cachedBlock!;
      final pos = bn * 8;
      if (pos + 8 > zdx.length) {
        throw FormatException('SWORD zLD block $bn out of range.');
      }
      final off = _u32(zdx, pos);
      final comp = _u32(zdx, pos + 4);
      if (off + comp > zdt.length) {
        throw FormatException('SWORD zLD block $bn extends past .zdt.');
      }
      final block =
          _decompress(Uint8List.sublistView(zdt, off, off + comp), compressType);
      cachedBlockNum = bn;
      cachedBlock = block;
      return block;
    }

    for (var i = 0; i < n; i++) {
      final start = _u32(idx, i * stride);
      final size = stride == 8 ? _u32(idx, i * stride + 4) : _u16(idx, i * stride + 4);
      if (size == 0 || start + size > dat.length) continue;
      final rec = Uint8List.sublistView(dat, start, start + size);
      final nl = rec.indexOf(0x0a);
      if (nl < 0 || nl + 1 + 8 > rec.length) continue;
      final key = _decode(Uint8List.sublistView(rec, 0, nl), isUtf8)
          .replaceAll('\r', '')
          .trim();
      if (key.isEmpty) continue;

      final blockNum = _u32(rec, nl + 1);
      final entryPos = _u32(rec, nl + 5);
      final block = blockFor(blockNum);
      // Block directory: count(u32), then count×(offset u32, size u32).
      if (4 + entryPos * 8 + 8 > block.length) continue;
      final bodyOff = _u32(block, 4 + entryPos * 8);
      final bodySize = _u32(block, 4 + entryPos * 8 + 4);
      if (bodyOff + bodySize > block.length) continue;
      final body =
          _decode(Uint8List.sublistView(block, bodyOff, bodyOff + bodySize), isUtf8);
      out.add(SwordLdEntry(key, body));
    }
    return SwordLdReader._(out);
  }

  /// Load a dictionary from the module's [dataDir]. The conf's `DataPath` for a
  /// dictionary is a file *basename* prefix (e.g. `…/easton/easton`), so
  /// [baseName] is that final path segment.
  static Future<SwordLdReader?> fromModuleDirectory(
    Directory dataDir,
    String baseName,
    SwordConfig config,
  ) async {
    final compressed = config.modDrv == SwordModDrv.zLD;
    final isUtf8 = config.isUtf8;
    File f(String ext) => File('${dataDir.path}/$baseName$ext');

    if (compressed) {
      final idx = f('.idx'), dat = f('.dat'), zdx = f('.zdx'), zdt = f('.zdt');
      if (!await idx.exists() ||
          !await dat.exists() ||
          !await zdx.exists() ||
          !await zdt.exists()) {
        return null;
      }
      return SwordLdReader.compressed(
        idx: await idx.readAsBytes(),
        dat: await dat.readAsBytes(),
        zdx: await zdx.readAsBytes(),
        zdt: await zdt.readAsBytes(),
        compressType: config.compressType ?? SwordCompressType.zip,
        isUtf8: isUtf8,
      );
    }

    final idx = f('.idx'), dat = f('.dat');
    if (!await idx.exists() || !await dat.exists()) return null;
    return SwordLdReader.raw(
      idx: await idx.readAsBytes(),
      dat: await dat.readAsBytes(),
      isUtf8: isUtf8,
    );
  }

  /// Pick the `.idx` record stride (6 or 8 bytes) by choosing the one whose
  /// records are evenly divisible and all in-bounds against the `.dat` length.
  /// RawLD uses a 16-bit size (6); zLD and RawLD4 use a 32-bit size (8).
  static int _detectStride(Uint8List idx, int datLen) {
    bool valid(int stride) {
      if (idx.isEmpty || idx.length % stride != 0) return false;
      final n = idx.length ~/ stride;
      for (var i = 0; i < n; i++) {
        final start = _u32(idx, i * stride);
        final size = stride == 8 ? _u32(idx, i * stride + 4) : _u16(idx, i * stride + 4);
        if (start + size > datLen) return false;
      }
      return true;
    }

    // Prefer 6 (RawLD's native layout); fall back to 8 (zLD/RawLD4).
    if (valid(6)) return 6;
    if (valid(8)) return 8;
    return 6;
  }

  static int _u32(Uint8List b, int o) =>
      ByteData.sublistView(b, o, o + 4).getUint32(0, Endian.little);
  static int _u16(Uint8List b, int o) =>
      ByteData.sublistView(b, o, o + 2).getUint16(0, Endian.little);

  static String _decode(Uint8List bytes, bool isUtf8) => isUtf8
      ? utf8.decode(bytes, allowMalformed: true)
      : latin1.decode(bytes, allowInvalid: true);

  static Uint8List _decompress(Uint8List data, SwordCompressType type) {
    switch (type) {
      case SwordCompressType.zip:
        return Uint8List.fromList(zlib.decode(data));
      case SwordCompressType.bzip2:
        return BZip2Decoder().decodeBytes(data);
      case SwordCompressType.lzss:
      case SwordCompressType.xz:
        throw UnsupportedError(
          'SWORD ${type.name.toUpperCase()} compression is not supported for '
          'dictionaries.',
        );
    }
  }
}
