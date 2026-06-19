import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/ui/reader/media_player_dialog.dart';

void main() {
  testWidgets('YoutubePlayerDialog', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MediaPlayerDialog(videoId: 'GQI72THyO5I'),
      ),
    ));
    // Not much we can assert without a real engine, but we can verify it doesn't crash.
  });
}
