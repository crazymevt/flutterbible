import 'dart:io';
import 'package:archive/archive_io.dart';

void main() {
  final bytes = File('test_extract2.zip.bz2').readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  print('Archive size: ${archive.length}');
  for (final f in archive) {
    print('Name: ${f.name}, isFile: ${f.isFile}, size: ${f.size}, type: ${f.runtimeType}');
  }
}
