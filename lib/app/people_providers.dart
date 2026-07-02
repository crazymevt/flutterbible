import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/content_store.dart';
import '../data/importer/theographic_importer.dart';
import 'content_providers.dart';
import 'reader_state.dart';

final theographicImporterProvider = Provider<TheographicImporter>(
  (ref) => TheographicImporter(ref.watch(contentStoreProvider)),
);

/// Loads the bundled Theographic people data into the DB on first access, then
/// resolves. Watch this before querying people so the UI can show progress.
final peopleReadyProvider = FutureProvider<bool>((ref) async {
  await ref.watch(theographicImporterProvider).ensureLoaded();
  return true;
});

class PersonSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void setQuery(String q) => state = q;
}

final personSearchQueryProvider =
    NotifierProvider<PersonSearchQueryNotifier, String>(
      () => PersonSearchQueryNotifier(),
    );

/// Person name search across name, display title, and alternate names.
/// Prefix matches rank first, then any substring match.
final personSearchResultsProvider = FutureProvider<List<BiblePerson>>((
  ref,
) async {
  await ref.watch(peopleReadyProvider.future);
  final store = ref.watch(contentStoreProvider);
  final query = ref.watch(personSearchQueryProvider).trim();
  if (query.isEmpty) return [];

  final pattern = '%$query%';
  final q = store.select(store.biblePeople)
    ..where(
      (p) =>
          p.name.like(pattern) |
          p.displayTitle.like(pattern) |
          p.alsoCalled.like(pattern),
    )
    ..orderBy([(p) => OrderingTerm.desc(p.verseCount)])
    ..limit(200);
  final rows = await q.get();

  final lower = query.toLowerCase();
  rows.sort((a, b) {
    final ap = a.name.toLowerCase().startsWith(lower) ? 0 : 1;
    final bp = b.name.toLowerCase().startsWith(lower) ? 0 : 1;
    if (ap != bp) return ap - bp;
    // Most-mentioned first within each rank, so "David" means the king.
    return b.verseCount.compareTo(a.verseCount);
  });
  return rows;
});

/// A timeline event a person participated in, with the event's first verse
/// (if any) so the UI can jump to the account.
class PersonEvent {
  final int eventId;
  final String title;
  final int? startYear;
  final String? bookName;
  final int? chapter;
  final int? verse;
  PersonEvent(
    this.eventId,
    this.title,
    this.startYear, {
    this.bookName,
    this.chapter,
    this.verse,
  });
}

class PersonDetail {
  final BiblePerson person;
  final BiblePerson? father;
  final BiblePerson? mother;
  final List<BiblePerson> partners;
  final List<BiblePerson> children;
  final List<BiblePerson> siblings;
  final List<String> groups;
  final List<PersonEvent> events;
  final List<PersonVerse> verses;
  PersonDetail({
    required this.person,
    required this.father,
    required this.mother,
    required this.partners,
    required this.children,
    required this.siblings,
    required this.groups,
    required this.events,
    required this.verses,
  });
}

final personDetailProvider = FutureProvider.family<PersonDetail?, int>((
  ref,
  personId,
) async {
  await ref.watch(peopleReadyProvider.future);
  final store = ref.watch(contentStoreProvider);
  final person = await (store.select(
    store.biblePeople,
  )..where((p) => p.id.equals(personId))).getSingleOrNull();
  if (person == null) return null;

  Future<BiblePerson?> byId(int? id) async => id == null
      ? null
      : await (store.select(
          store.biblePeople,
        )..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<BiblePerson>> byIds(List<int> ids) async {
    if (ids.isEmpty) return const [];
    final rows = await (store.select(
      store.biblePeople,
    )..where((p) => p.id.isIn(ids))).get();
    // Oldest-first where years are known, then by name.
    rows.sort((a, b) {
      final ay = a.minYear, by = b.minYear;
      if (ay != null && by != null && ay != by) return ay.compareTo(by);
      return a.name.compareTo(b.name);
    });
    return rows;
  }

  // Spouses are stored one-directional in places; match either side.
  final partnerLinks =
      await (store.select(store.personPartners)..where(
            (r) => r.personId.equals(personId) | r.partnerId.equals(personId),
          ))
          .get();
  final partnerIds = {
    for (final r in partnerLinks)
      r.personId == personId ? r.partnerId : r.personId,
  }..remove(personId);

  final childRows =
      await (store.select(store.biblePeople)..where(
            (p) => p.fatherId.equals(personId) | p.motherId.equals(personId),
          ))
          .get();

  // Siblings share a parent; derived rather than stored.
  final siblingIds = <int>{};
  if (person.fatherId != null || person.motherId != null) {
    final rows =
        await (store.select(store.biblePeople)..where((p) {
              Expression<bool> sharesParent = const Constant(false);
              if (person.fatherId != null) {
                sharesParent =
                    sharesParent | p.fatherId.equals(person.fatherId!);
              }
              if (person.motherId != null) {
                sharesParent =
                    sharesParent | p.motherId.equals(person.motherId!);
              }
              return sharesParent;
            }))
            .get();
    for (final r in rows) {
      if (r.id != personId) siblingIds.add(r.id);
    }
  }

  final groupRows = await store
      .customSelect(
        'SELECT g.name AS name FROM people_group_members m '
        'JOIN people_groups g ON g.id = m.group_id '
        'WHERE m.person_id = ? ORDER BY g.name',
        variables: [Variable.withInt(personId)],
      )
      .get();

  final eventRows = await store
      .customSelect(
        'SELECT e.id AS id, e.title AS title, e.start_year AS start_year, '
        '       ev.book_name AS book_name, ev.chapter AS chapter, ev.verse AS verse '
        'FROM event_participants ep '
        'JOIN timeline_events e ON e.id = ep.event_id '
        'LEFT JOIN event_verses ev ON ev.event_id = e.id AND ev.ord = 0 '
        'WHERE ep.person_id = ? '
        'ORDER BY e.sort_key IS NULL, e.sort_key',
        variables: [Variable.withInt(personId)],
      )
      .get();

  // Import order is canonical scripture order.
  final verses =
      await (store.select(store.personVerses)
            ..where((v) => v.personId.equals(personId))
            ..orderBy([(v) => OrderingTerm.asc(v.id)]))
          .get();

  final children = await byIds(childRows.map((c) => c.id).toList());
  return PersonDetail(
    person: person,
    father: await byId(person.fatherId),
    mother: await byId(person.motherId),
    partners: await byIds(partnerIds.toList()),
    children: children,
    siblings: await byIds(siblingIds.toList()),
    groups: groupRows.map((r) => r.read<String>('name')).toList(),
    events: eventRows
        .map(
          (r) => PersonEvent(
            r.read<int>('id'),
            r.read<String>('title'),
            r.readNullable<int>('start_year'),
            bookName: r.readNullable<String>('book_name'),
            chapter: r.readNullable<int>('chapter'),
            verse: r.readNullable<int>('verse'),
          ),
        )
        .toList(),
    verses: verses,
  );
});

/// A person mentioned in the active passage, with the verses (in this chapter)
/// that mention them.
class PersonInPassage {
  final int id;
  final String displayTitle;
  final int verseCount;
  final List<int> verses;
  PersonInPassage({
    required this.id,
    required this.displayTitle,
    required this.verseCount,
    required this.verses,
  });
}

/// People mentioned in (book, chapter) — the "people in this passage" lookup.
final peopleForPassageProvider =
    FutureProvider.family<List<PersonInPassage>, ({String book, int chapter})>((
      ref,
      loc,
    ) async {
      await ref.watch(peopleReadyProvider.future);
      final store = ref.watch(contentStoreProvider);
      final rows = await store
          .customSelect(
            '''
    SELECT p.id AS id, p.display_title AS title, p.verse_count AS verse_count,
           pv.verse AS verse
    FROM person_verses pv
    JOIN bible_people p ON p.id = pv.person_id
    WHERE pv.book_name = ? AND pv.chapter = ?
    ORDER BY pv.verse
    ''',
            variables: [
              Variable.withString(loc.book),
              Variable.withInt(loc.chapter),
            ],
          )
          .get();

      final byId = <int, PersonInPassage>{};
      for (final r in rows) {
        final id = r.read<int>('id');
        final verse = r.read<int>('verse');
        final existing = byId[id];
        if (existing == null) {
          byId[id] = PersonInPassage(
            id: id,
            displayTitle: r.read<String>('title'),
            verseCount: r.read<int>('verse_count'),
            verses: [verse],
          );
        } else {
          existing.verses.add(verse);
        }
      }
      final list = byId.values.toList()
        ..sort((a, b) => a.displayTitle.compareTo(b.displayTitle));
      return list;
    });

/// Convenience: people for the currently selected book + chapter.
final currentPassagePeopleProvider = FutureProvider<List<PersonInPassage>>((
  ref,
) async {
  final book = ref.watch(selectedBookNameProvider);
  final chapter = ref.watch(selectedChapterProvider);
  return ref.watch(
    peopleForPassageProvider((book: book, chapter: chapter)).future,
  );
});

/// The person currently focused in the People panel.
class SelectedPersonNotifier extends Notifier<int?> {
  @override
  int? build() => null;
  void select(int? id) => state = id;
}

final selectedPersonProvider = NotifierProvider<SelectedPersonNotifier, int?>(
  () => SelectedPersonNotifier(),
);

// --- Timeline chart data ---

/// A person with a known lifespan, for the timeline chart. Years are ISO
/// years (negative = BC).
class TimelinePerson {
  final int id;
  final String displayTitle;
  final int birthYear;
  final int deathYear;
  const TimelinePerson({
    required this.id,
    required this.displayTitle,
    required this.birthYear,
    required this.deathYear,
  });
}

/// People who have both a birth and death year, sorted oldest-first — the
/// lifespan bars of the timeline. About 50 major figures from Adam onward.
final timelinePeopleProvider = FutureProvider<List<TimelinePerson>>((
  ref,
) async {
  await ref.watch(peopleReadyProvider.future);
  final store = ref.watch(contentStoreProvider);
  final rows =
      await (store.select(store.biblePeople)
            ..where((p) => p.birthYear.isNotNull() & p.deathYear.isNotNull())
            ..orderBy([
              (p) => OrderingTerm.asc(p.birthYear),
              (p) => OrderingTerm.asc(p.deathYear),
            ]))
          .get();
  return [
    for (final p in rows)
      TimelinePerson(
        id: p.id,
        displayTitle: p.displayTitle,
        birthYear: p.birthYear!,
        deathYear: p.deathYear!,
      ),
  ];
});

/// A dated event, for the timeline chart, carrying its first verse (if any)
/// so the chart can jump to the account.
class TimelineEventPoint {
  final int id;
  final String title;
  final int year;
  final String? bookName;
  final int? chapter;
  final int? verse;
  const TimelineEventPoint({
    required this.id,
    required this.title,
    required this.year,
    this.bookName,
    this.chapter,
    this.verse,
  });
}

/// Events with an explicit start year, sorted chronologically — the markers
/// laid over the timeline.
final timelineEventsProvider = FutureProvider<List<TimelineEventPoint>>((
  ref,
) async {
  await ref.watch(peopleReadyProvider.future);
  final store = ref.watch(contentStoreProvider);
  final rows = await store
      .customSelect(
        'SELECT e.id AS id, e.title AS title, e.start_year AS year, '
        '       ev.book_name AS book_name, ev.chapter AS chapter, ev.verse AS verse '
        'FROM timeline_events e '
        'LEFT JOIN event_verses ev ON ev.event_id = e.id AND ev.ord = 0 '
        'WHERE e.start_year IS NOT NULL '
        'ORDER BY e.start_year',
      )
      .get();
  return [
    for (final r in rows)
      TimelineEventPoint(
        id: r.read<int>('id'),
        title: r.read<String>('title'),
        year: r.read<int>('year'),
        bookName: r.readNullable<String>('book_name'),
        chapter: r.readNullable<int>('chapter'),
        verse: r.readNullable<int>('verse'),
      ),
  ];
});

/// The bundled data for the timeline: dated people and events plus the overall
/// year span, resolved together so the chart has one thing to await.
class TimelineData {
  final List<TimelinePerson> people;
  final List<TimelineEventPoint> events;
  final int minYear;
  final int maxYear;
  const TimelineData({
    required this.people,
    required this.events,
    required this.minYear,
    required this.maxYear,
  });

  bool get isEmpty => people.isEmpty && events.isEmpty;
}

final timelineDataProvider = FutureProvider<TimelineData>((ref) async {
  final people = await ref.watch(timelinePeopleProvider.future);
  final events = await ref.watch(timelineEventsProvider.future);

  var minY = 0, maxY = 0;
  var seeded = false;
  void extend(int lo, int hi) {
    if (!seeded) {
      minY = lo;
      maxY = hi;
      seeded = true;
    } else {
      if (lo < minY) minY = lo;
      if (hi > maxY) maxY = hi;
    }
  }

  for (final p in people) {
    final lo = p.birthYear <= p.deathYear ? p.birthYear : p.deathYear;
    final hi = p.birthYear <= p.deathYear ? p.deathYear : p.birthYear;
    extend(lo, hi);
  }
  for (final e in events) {
    extend(e.year, e.year);
  }
  if (!seeded) {
    minY = 0;
    maxY = 100;
  }

  // Pad to the enclosing century so the axis starts and ends on round labels.
  int floorTo(int v, int step) => (v / step).floor() * step;
  int ceilTo(int v, int step) => (v / step).ceil() * step;
  return TimelineData(
    people: people,
    events: events,
    minYear: floorTo(minY, 100),
    maxYear: ceilTo(maxY, 100),
  );
});
