import 'dart:io';
import 'package:archive/archive_io.dart';

void main() {
  final bytes = File('test_extract2.zip.bz2').readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  for (final file in archive) {
    if (file.isFile) {
      final data = file.content as List<int>;
      print('Name: ${file.name}, size from property: ${file.size}, length of data array: ${data.length}');
      File('test_write.bin').writeAsBytesSync(data);
      print('Written size: ${File('test_write.bin').lengthSync()}');
    }
  }
}
