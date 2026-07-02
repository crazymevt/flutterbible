import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/app/content_providers.dart';
import 'package:study_bible/app/people_providers.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/ui/reader/people_timeline_screen.dart';

/// Smoke-tests the fullscreen timeline: it lays out the pinned name gutter and
/// lifespan bars from seeded data, and the zoom/fit/help controls run without
/// throwing.
void main() {
  late ContentStore store;

  Future<void> person(int id, String name, int birth, int death) =>
      store.into(store.biblePeople).insert(BiblePeopleCompanion(
            id: Value(id),
            slug: Value(name.toLowerCase()),
            name: Value(name),
            displayTitle: Value(name),
            birthYear: Value(birth),
            deathYear: Value(death),
            verseCount: const Value(0),
          ));

  setUp(() async {
    store = ContentStore(NativeDatabase.memory());
    await person(1, 'Adam', -4004, -3074);
    await person(2, 'Seth', -3874, -2692);
    await person(3, 'Noah', -2948, -1998);
    await store.into(store.timelineEvents).insert(const TimelineEventsCompanion(
        id: Value(1),
        title: Value('Creation'),
        sortKey: Value(-4002.9),
        startYear: Value(-4003)));
    await store.into(store.timelineEvents).insert(const TimelineEventsCompanion(
        id: Value(2),
        title: Value('The Flood'),
        sortKey: Value(-2348.0),
        startYear: Value(-2348)));
  });

  tearDown(() async {
    await store.close();
  });

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contentStoreProvider.overrideWithValue(store),
          peopleReadyProvider.overrideWith((ref) async => true),
        ],
        child: const MaterialApp(home: PeopleTimelineScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders the axis, gutter names, and lifespan bars',
      (tester) async {
    await pump(tester);

    expect(find.text('Bible Timeline'), findsOneWidget);
    expect(find.text('3 people'), findsOneWidget);
    // Names appear in the pinned gutter.
    expect(find.text('Adam'), findsOneWidget);
    expect(find.text('Noah'), findsOneWidget);
  });

  testWidgets('zoom, fit, and help controls run without error', (tester) async {
    await pump(tester);

    await tester.tap(find.byTooltip('Zoom in'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Zoom out'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Fit all'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('How to read this'));
    await tester.pumpAndSettle();
    expect(find.text('Got it'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping a name opens that person', (tester) async {
    await pump(tester);

    await tester.tap(find.text('Adam'));
    await tester.pumpAndSettle();

    // The person detail sheet (PeoplePanel) opens with a back control...
    expect(find.byTooltip('Back to list'), findsOneWidget);
    // ...but without the Timeline button, so it can't stack a second timeline
    // on top of the one already open.
    expect(find.byTooltip('Timeline'), findsNothing);
  });

  testWidgets('Events view lists and searches events chronologically',
      (tester) async {
    await pump(tester);

    await tester.tap(find.text('Events'));
    await tester.pumpAndSettle();

    expect(find.text('Creation'), findsOneWidget);
    expect(find.text('The Flood'), findsOneWidget);

    // Search narrows the list.
    await tester.enterText(find.byType(TextField), 'flood');
    await tester.pumpAndSettle();
    expect(find.text('The Flood'), findsOneWidget);
    expect(find.text('Creation'), findsNothing);

    // Tapping an event opens its detail sheet with the jump-to-timeline action.
    await tester.tap(find.text('The Flood'));
    await tester.pumpAndSettle();
    expect(find.text('Show on timeline'), findsOneWidget);

    // "Show on timeline" returns to the chart.
    await tester.tap(find.text('Show on timeline'));
    await tester.pumpAndSettle();
    expect(find.text('3 people'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
