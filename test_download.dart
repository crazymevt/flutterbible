import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://www.ph4.org/_dl.php?back=bbl&a=KJV_plus_&b=mybible&c', 
      options: Options(
        responseType: ResponseType.bytes,
        validateStatus: (status) => true,
        headers: {
          'User-Agent': 'Mozilla/5.0',
        }
      )
    );
    print('Status: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Data length: ${response.data.length}');
    if (response.data.length < 500) {
      print('Data: ${String.fromCharCodes(response.data)}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
