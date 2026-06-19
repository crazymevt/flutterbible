import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  // Download KJV from ph4
  final url = 'https://www.ph4.org/b4_1_dl.php?a=KJV';
  final tempDir = Directory.systemTemp.createTempSync('ph4test');
  final dlFile = File(p.join(tempDir.path, 'kjv.zip.bz2'));
  print('Downloading to ${dlFile.path}...');
  await dio.download(url, dlFile.path);

  print('Downloaded. File size: ${dlFile.lengthSync()}');

  final bytes = dlFile.readAsBytesSync();
  Archive? archive;
  try {
    final bzip2Decoder = BZip2Decoder();
    final uncompressed = bzip2Decoder.decodeBytes(bytes);
    print('Uncompressed BZ2 size: ${uncompressed.length}');
    archive = ZipDecoder().decodeBytes(uncompressed);
  } catch (e) {
    print('BZ2 decode failed: $e. Trying plain Zip...');
    try {
      archive = ZipDecoder().decodeBytes(bytes);
    } catch (e2) {
      print('Zip decode failed: $e2');
    }
  }

  if (archive != null) {
    print('Archive decoded. Contains ${archive.length} files.');
    for (final f in archive) {
      print(' - ${f.name} (isFile: ${f.isFile}, size: ${f.size})');
    }
  }
}
