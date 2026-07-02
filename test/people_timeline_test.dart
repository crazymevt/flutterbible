import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/app/content_providers.dart';
import 'package:study_bible/app/people_providers.dart';

/// Exercises the timeline data assembly: only people with both a birth and
/// death year become lifespan bars (sorted oldest-first), only events with a
/// start year become markers (carrying their first verse), and the axis span
/// is padded to the enclosing century.
void main() {
  late ContentStore store;
  late ProviderContainer container;

  Future<void> person(int id, String name,
          {int? birth, int? death}) =>
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

    await person(1, 'Adam', birth: -4004, death: -3074);
    await person(2, 'Seth', birth: -3874, death: -2692);
    // No death year -> excluded from lifespan bars.
    await person(3, 'Enoch', birth: -3382);
    // No years at all -> excluded.
    await person(4, 'Anon');

    // Dated event with a first verse.
    await store.into(store.timelineEvents).insert(const TimelineEventsCompanion(
        id: Value(1),
        title: Value('Creation of all things'),
        sortKey: Value(-4002.9),
        startYear: Value(-4003)));
    await store.into(store.eventVerses).insert(const EventVersesCompanion(
        id: Value(1),
        eventId: Value(1),
        ord: Value(0),
        bookName: Value('Genesis'),
        chapter: Value(1),
        verse: Value(1)));
    // Event without a start year -> excluded.
    await store.into(store.timelineEvents).insert(const TimelineEventsCompanion(
        id: Value(2), title: Value('Undated'), sortKey: Value(1.0)));

    container = ProviderContainer(overrides: [
      contentStoreProvider.overrideWithValue(store),
      peopleReadyProvider.overrideWith((ref) async => true),
    ]);
  });

  tearDown(() async {
    container.dispose();
    await store.close();
  });

  test('only fully-dated people become bars, oldest first', () async {
    final people = await container.read(timelinePeopleProvider.future);
    expect(people.map((p) => p.displayTitle), ['Adam', 'Seth']);
    expect(people.first.birthYear, -4004);
    expect(people.first.deathYear, -3074);
  });

  test('only events with a start year become markers, with first verse',
      () async {
    final events = await container.read(timelineEventsProvider.future);
    expect(events.length, 1);
    final e = events.single;
    expect(e.title, 'Creation of all things');
    expect(e.year, -4003);
    expect(e.bookName, 'Genesis');
    expect(e.chapter, 1);
    expect(e.verse, 1);
  });

  test('axis span is padded to the enclosing century', () async {
    final data = await container.read(timelineDataProvider.future);
    // Earliest point -4004 floors to -4100; latest -2692 ceils to -2600.
    expect(data.minYear, -4100);
    expect(data.maxYear, -2600);
    expect(data.people.length, 2);
    expect(data.events.length, 1);
    expect(data.isEmpty, isFalse);
  });
}
