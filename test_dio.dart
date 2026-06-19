import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  final dioDownload = Dio(BaseOptions(
    headers: {'User-Agent': 'Mozilla/5.0 (StudyBible Flutter)'},
  ));
  
  final url = 'https://www.ph4.org/_dl.php?back=bbl&a=KJV_plus_&b=mybible&c';
  final dlFile = File('test_dio.zip.bz2');
  
  print('Downloading...');
  await dioDownload.download(url, dlFile.path);
  
  print('Size: ${dlFile.lengthSync()} bytes');
}
