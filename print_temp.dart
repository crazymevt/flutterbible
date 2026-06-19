import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  final dir = Directory(Directory.systemTemp.path);
  print('System temp: ${dir.path}');
  // We can't use path_provider in a plain dart script without flutter test environment.
}
