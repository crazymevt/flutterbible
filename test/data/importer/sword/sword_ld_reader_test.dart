import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/data/importer/sword/sword_ld_reader.dart';

Uint8List _le32(int v) =>
    (ByteData(4)..setUint32(0, v, Endian.little)).buffer.asUint8List();
Uint8List _le16(int v) =>
    (ByteData(2)..setUint16(0, v, Endian.little)).buffer.asUint8List();
Uint8List _concat(List<List<int>> parts) {
  final b = BytesBuilder();
  for (final p in parts) {
    b.add(p);
  }
  return b.toBytes();
}

void main() {
  group('SwordLdReader.raw (RawLD)', () {
    // Two entries: "A" and "AARON", each `KEY\r\n<body>` in .dat, indexed by a
    // 6-byte (offset u32 + size u16) .idx.
    final recA = utf8.encode('A\r\n<p>First letter.</p>');
    final recB = utf8.encode('AARON\r\n<p>Brother of Moses.</p>');
    final dat = _concat([recA, recB]);
    final idx = _concat([
      _concat([_le32(0), _le16(recA.length)]),
      _concat([_le32(recA.length), _le16(recB.length)]),
    ]);

    test('decodes key/body pairs', () {
      final r = SwordLdReader.raw(
          idx: idx, dat: Uint8List.fromList(dat));
      expect(r.entries.map((e) => e.key), ['A', 'AARON']);
      expect(r.entries[0].body, '<p>First letter.</p>');
      expect(r.entries[1].body, '<p>Brother of Moses.</p>');
    });
  });

  group('SwordLdReader.compressed (zLD)', () {
    // One zlib block holding two entry bodies, with a count + (offset,size)
    // directory; .dat records carry the key plus blockNum/entryPos pointers.
    final body0 = utf8.encode('<entryFree><title>A</title></entryFree>');
    final body1 = utf8.encode('<entryFree><title>Aaron</title></entryFree>');
    final headerLen = 4 + 2 * 8; // count + two (offset,size) records
    final block = _concat([
      _le32(2),
      _concat([_le32(headerLen), _le32(body0.length)]),
      _concat([_le32(headerLen + body0.length), _le32(body1.length)]),
      body0,
      body1,
    ]);
    final comp = zlib.encode(block);
    final zdt = Uint8List.fromList(comp);
    final zdx = _concat([_le32(0), _le32(comp.length)]); // one block

    // .dat: `KEY\r\n` + blockNum(u32) + entryPos(u32); .idx is 8-byte here.
    final recA = _concat([utf8.encode('A\r\n'), _le32(0), _le32(0)]);
    final recB = _concat([utf8.encode('AARON\r\n'), _le32(0), _le32(1)]);
    final dat = _concat([recA, recB]);
    final idx = _concat([
      _concat([_le32(0), _le32(recA.length)]),
      _concat([_le32(recA.length), _le32(recB.length)]),
    ]);

    test('decodes keys and pulls bodies from the compressed block', () {
      final r = SwordLdReader.compressed(
        idx: idx,
        dat: Uint8List.fromList(dat),
        zdx: zdx,
        zdt: zdt,
      );
      expect(r.entries.map((e) => e.key), ['A', 'AARON']);
      expect(r.entries[0].body, '<entryFree><title>A</title></entryFree>');
      expect(r.entries[1].body, '<entryFree><title>Aaron</title></entryFree>');
    });
  });
}
