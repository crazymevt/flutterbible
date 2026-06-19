import 'package:archive/archive.dart';
import 'dart:typed_data';

void main() {
  final archive = Archive();
  final fileBytes = Uint8List.fromList([1, 2, 3]);
  archive.addFile(ArchiveFile('sermon1.txt', fileBytes.length, fileBytes));
  final zipBytes = ZipEncoder().encode(archive);
  print(zipBytes?.length);
}
