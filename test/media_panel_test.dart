import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_bible/ui/reader/media_panel.dart';

void main() {
  testWidgets('MediaPanel loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: MediaPanel(bookName: 'Genesis', chapter: 1),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
}
