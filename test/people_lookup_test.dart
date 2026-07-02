import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_bible/data/content_store.dart';
import 'package:study_bible/app/content_providers.dart';
import 'package:study_bible/app/people_providers.dart';

/// Exercises the people lookups: "people in this passage" grouping, and the
/// person detail's derived relationships (children from parent links, siblings
/// from shared parents, spouses matched from either side of the link).
void main() {
  late ContentStore store;
  late ProviderContainer container;

  // 1 Amram, 2 Jochebed, 3 Aaron, 4 Moses, 5 Miriam, 6 Elisheba.
  Future<void> person(int id, String name,
          {int? father, int? mother, int verseCount = 0}) =>
      store.into(store.biblePeople).insert(BiblePeopleCompanion(
            id: Value(id),
            slug: Value(name.toLowerCase()),
            name: Value(name),
            displayTitle: Value(name),
            fatherId: Value(father),
            motherId: Value(mother),
            verseCount: Value(verseCount),
          ));

  setUp(() async {
    store = ContentStore(NativeDatabase.memory());

    await person(1, 'Amram');
    await person(2, 'Jochebed');
    await person(3, 'Aaron', father: 1, mother: 2, verseCount: 3);
    await person(4, 'Moses', father: 1, mother: 2, verseCount: 2);
    await person(5, 'Miriam', father: 1, mother: 2);
    await person(6, 'Elisheba');

    // Stored one-directional: Aaron -> Elisheba.
    await store.into(store.personPartners).insert(const PersonPartnersCompanion(
        id: Value(1), personId: Value(3), partnerId: Value(6)));

    Future<void> pv(int id, int p, String book, int ch, int v) =>
        store.into(store.personVerses).insert(PersonVersesCompanion(
            id: Value(id),
            personId: Value(p),
            bookName: Value(book),
            chapter: Value(ch),
            verse: Value(v)));
    // Exodus 4: Aaron (v14, v27), Moses (v14). Aaron also in Exodus 5.
    await pv(1, 3, 'Exodus', 4, 14);
    await pv(2, 3, 'Exodus', 4, 27);
    await pv(3, 4, 'Exodus', 4, 14);
    await pv(4, 3, 'Exodus', 5, 1);

    await store.into(store.peopleGroups).insert(const PeopleGroupsCompanion(
        id: Value(1), name: Value('Tribe of Levi')));
    await store
        .into(store.peopleGroupMembers)
        .insert(const PeopleGroupMembersCompanion(
            id: Value(1), groupId: Value(1), personId: Value(3)));

    await store.into(store.timelineEvents).insert(const TimelineEventsCompanion(
        id: Value(1),
        title: Value('The Exodus'),
        sortKey: Value(-1446.5),
        startYear: Value(-1446)));
    await store
        .into(store.eventParticipants)
        .insert(const EventParticipantsCompanion(
            id: Value(1), eventId: Value(1), personId: Value(3)));
    await store.into(store.eventVerses).insert(const EventVersesCompanion(
        id: Value(1),
        eventId: Value(1),
        ord: Value(0),
        bookName: Value('Exodus'),
        chapter: Value(12),
        verse: Value(31)));

    container = ProviderContainer(overrides: [
      contentStoreProvider.overrideWithValue(store),
      // Skip the asset-loading step; rows are seeded directly above.
      peopleReadyProvider.overrideWith((ref) async => true),
    ]);
  });

  tearDown(() async {
    container.dispose();
    await store.close();
  });

  test('people in a passage are grouped with their verses in that chapter',
      () async {
    final list = await container.read(
        peopleForPassageProvider((book: 'Exodus', chapter: 4)).future);
    expect(list.map((p) => p.displayTitle), ['Aaron', 'Moses']);
    expect(list.first.verses, [14, 27]);
    expect(list.last.verses, [14]);
  });

  test('a chapter with no tagged people yields an empty list', () async {
    final list = await container
        .read(peopleForPassageProvider((book: 'Genesis', chapter: 1)).future);
    expect(list, isEmpty);
  });

  test('person detail derives family from parent links', () async {
    final d = (await container.read(personDetailProvider(3).future))!;
    expect(d.person.name, 'Aaron');
    expect(d.father?.name, 'Amram');
    expect(d.mother?.name, 'Jochebed');
    expect(d.siblings.map((s) => s.name).toSet(), {'Moses', 'Miriam'});
    expect(d.partners.map((s) => s.name), ['Elisheba']);
    expect(d.groups, ['Tribe of Levi']);
    expect(d.verses.length, 3);

    // Events carry their first verse so the UI can jump to the account.
    expect(d.events.single.title, 'The Exodus');
    expect(d.events.single.bookName, 'Exodus');
    expect(d.events.single.chapter, 12);
  });

  test('spouse links resolve from the other side too', () async {
    final d = (await container.read(personDetailProvider(6).future))!;
    expect(d.person.name, 'Elisheba');
    expect(d.partners.map((s) => s.name), ['Aaron']);
  });

  test('parents list their children', () async {
    final d = (await container.read(personDetailProvider(1).future))!;
    expect(d.children.map((c) => c.name).toSet(), {'Aaron', 'Moses', 'Miriam'});
    expect(d.siblings, isEmpty);
  });

  test('person search matches alternate names and ranks prefix first',
      () async {
    await store.customStatement(
        "UPDATE bible_people SET also_called = 'Ner, Jehiel' WHERE id = 6");
    container.read(personSearchQueryProvider.notifier).setQuery('Jehiel');
    final byAka = await container.read(personSearchResultsProvider.future);
    expect(byAka.map((p) => p.name), ['Elisheba']);

    container.read(personSearchQueryProvider.notifier).setQuery('M');
    final byPrefix = await container.read(personSearchResultsProvider.future);
    // Prefix matches (Moses, Miriam) before substring matches (Amram, ...),
    // most-mentioned first within each rank.
    expect(byPrefix.first.name, 'Moses');
    expect(byPrefix[1].name, 'Miriam');
  });
}
