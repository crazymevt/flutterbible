import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

void main() {
  final controller = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
    readOnly: true,
  );
  final editor = QuillEditor.basic(
    configurations: QuillEditorConfigurations(
      controller: controller,
      showCursor: false,
      sharedConfigurations: const QuillSharedConfigurations(
        locale: Locale('en'),
      ),
    ),
  );
}
