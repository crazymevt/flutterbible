import 'dart:io';
import 'package:dio/dio.dart';
import 'package:study_bible/domain/importer/archive_extractor.dart';

void main() async {
  final dioDownload = Dio(BaseOptions(
    headers: {'User-Agent': 'Mozilla/5.0 (StudyBible Flutter)'},
  ));
  
  final url = 'https://www.ph4.org/_dl.php?back=bbl&a=KJV_plus_&b=mybible&c';
  final dlFile = File('test_extract2.zip.bz2');
  
  print('Downloading...');
  await dioDownload.download(url, dlFile.path);
  
  print('Extracting...');
  final extractDir = Directory('test_extract2_dir');
  if (extractDir.existsSync()) extractDir.deleteSync(recursive: true);
  extractDir.createSync();
  
  final extractedFiles = await ArchiveExtractor.extractArchive(dlFile, extractDir);
  for (final f in extractedFiles) {
    print('Extracted: ${f.path}');
  }
}
