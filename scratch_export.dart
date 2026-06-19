import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';

void main() async {
  await Share.shareXFiles([
    XFile.fromData(Uint8List(0), name: 'sermons.pdf', mimeType: 'application/pdf')
  ]);
}
