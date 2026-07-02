import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_bible/app/content_providers.dart';
import 'package:study_bible/app/people_providers.dart';
import 'package:study_bible/app/shared_prefs.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/ui/reader/people_panel.dart';

/// Smoke-tests the People panel views with seeded rows: the person detail
/// (family chips, bio, timeline, verse groups) and drilling from a family
/// chip to the relative's detail.
void main() {
  late ContentStore store;

  Future<void> person(int id, String name,
          {int? father, String? bio, int? birthYear, int? deathYear}) =>
      store.into(store.biblePeople).insert(BiblePeopleCompanion(
            id: Value(id),
            slug: Value(name.toLowerCase()),
            name: Value(name),
            displayTitle: Value(name),
            fatherId: Value(father),
            bio: Value(bio),
            birthYear: Value(birthYear),
            deathYear: Value(deathYear),
            verseCount: const Value(1),
          ));

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'selectedBookName': 'Exodus',
      'selectedChapter': 4,
    });
    store = ContentStore(NativeDatabase.memory());
    await person(1, 'Amram');
    await person(2, 'Aaron',
        father: 1,
        bio: 'The eldest son of Amram.',
        birthYear: -1574,
        deathYear: -1451);
    await store.into(store.personVerses).insert(const PersonVersesCompanion(
        id: Value(1),
        personId: Value(2),
        bookName: Value('Exodus'),
        chapter: Value(4),
        verse: Value(14)));
  });

  tearDown(() async {
    await store.close();
  });

  Future<ProviderContainer> pumpPanel(WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      contentStoreProvider.overrideWithValue(store),
      peopleReadyProvider.overrideWith((ref) async => true),
    ]);
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: PeoplePanel())),
      ),
    );
    return container;
  }

  testWidgets('person detail shows years, family, bio, and verse groups',
      (tester) async {
    final container = await pumpPanel(tester);
    container.read(selectedPersonProvider.notifier).select(2);
    await tester.pumpAndSettle();

    expect(find.text('Aaron'), findsOneWidget);
    expect(find.textContaining('1574 BC – 1451 BC'), findsOneWidget);
    expect(find.text('Father'), findsOneWidget);
    expect(find.text('The eldest son of Amram.'), findsOneWidget);
    expect(find.text('Exodus (1)'), findsOneWidget);
  });

  testWidgets('tapping a family chip opens that relative', (tester) async {
    final container = await pumpPanel(tester);
    container.read(selectedPersonProvider.notifier).select(2);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ActionChip, 'Amram'));
    await tester.pumpAndSettle();

    expect(container.read(selectedPersonProvider), 1);
    // Amram's detail lists Aaron as his child.
    expect(find.text('Children'), findsOneWidget);
    expect(find.widgetWithText(ActionChip, 'Aaron'), findsOneWidget);
  });

  testWidgets('search lists matches and opens the tapped person',
      (tester) async {
    final container = await pumpPanel(tester);
    await tester.enterText(find.byType(TextField), 'Aar');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Aaron'));
    await tester.pumpAndSettle();
    expect(container.read(selectedPersonProvider), 2);
  });
}
