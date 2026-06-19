import 'dart:io';
import 'package:dio/dio.dart';
import 'package:archive/archive_io.dart';

void main() async {
  final dio = Dio();
  final response = await dio.get('https://www.ph4.org/_dl.php?back=bbl&a=KJV_plus_&b=mybible&c', 
      options: Options(responseType: ResponseType.bytes, headers: {'User-Agent': 'Mozilla/5.0'}));
  
  final bytes = response.data as List<int>;
  print('Downloaded ${bytes.length} bytes.');
  final archive = ZipDecoder().decodeBytes(bytes);
  for (final file in archive) {
    print('File in zip: ${file.name}');
  }
}
