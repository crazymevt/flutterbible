import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/app/tag_providers.dart';
import 'package:study_bible/ui/tags/tag_editor_dialog.dart';

/// Guards the manage-tags dialog against overflowing when the soft keyboard is
/// up. Flutter's Dialog shifts up by the keyboard inset, so on short screens
/// the body must scroll rather than overflow (the bug this reproduces).
void main() {
  TagData tag(int i) => TagData(id: 't$i', name: 'tag$i');

  Widget harness({required double keyboardInset}) {
    final container = ProviderContainer(overrides: [
      // Several applied tags so the fixed content is tall enough to overflow
      // the keyboard-shrunk dialog if the body weren't scrollable.
      tagsForEntityProvider('e1').overrideWith((ref) => Stream.value([
            for (var i = 0; i < 6; i++)
              EntityTagData(
                id: 'et$i',
                tagId: 't$i',
                entityId: 'e1',
                entityType: 'note',
                tag: tag(i),
              ),
          ])),
      allTagsProvider
          .overrideWith((ref) => Stream.value([for (var i = 0; i < 12; i++) tag(i)])),
    ]);
    addTearDown(container.dispose);
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: MediaQuery(
          // Simulate a raised keyboard eating most of the vertical space.
          data: MediaQueryData(viewInsets: EdgeInsets.only(bottom: keyboardInset)),
          child: const Scaffold(
            body: TagEditorDialog(entityId: 'e1', entityType: 'note'),
          ),
        ),
      ),
    );
  }

  testWidgets('lays out without overflow when the keyboard is up',
      (tester) async {
    await tester.pumpWidget(harness(keyboardInset: 420));
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    // The body is scrollable so tight layouts stay reachable.
    expect(find.byType(SingleChildScrollView), findsWidgets);
    expect(find.text('Manage Tags'), findsOneWidget);
  });

  testWidgets('lays out without overflow with the keyboard down',
      (tester) async {
    await tester.pumpWidget(harness(keyboardInset: 0));
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Manage Tags'), findsOneWidget);
  });
}
