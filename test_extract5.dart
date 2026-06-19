import 'dart:io';
import 'package:archive/archive_io.dart';

void main() {
  final bytes = File('test_extract2.zip.bz2').readAsBytesSync(); // This is the 2.6MB zip file!
  final bzip2Decoder = BZip2Decoder();
  try {
    final uncompressed = bzip2Decoder.decodeBytes(bytes);
    print('Uncompressed BZ2 size: ${uncompressed.length}');
    final archive = ZipDecoder().decodeBytes(uncompressed);
    print('Archive decoded. Contains ${archive.length} files.');
  } catch (e) {
    print('BZ2 decode threw: $e');
  }
}
