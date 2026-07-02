import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../content_store.dart';

/// Loads the bundled Theographic Bible Metadata asset (people, people groups,
/// and timeline events) into the content store on first use. Data is
/// CC BY-SA 4.0 (robertrouse/theographic-bible-metadata by Viz.Bible),
/// converted to JSON by `scripts/build_theographic.dart`.
class TheographicImporter {
  TheographicImporter(this.store);

  final ContentStore store;

  static const String assetPath = 'assets/data/theographic.json';

  Future<int> _personCount() async {
    final countExp = store.biblePeople.id.count();
    final query = store.selectOnly(store.biblePeople)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle() ?? 0;
  }

  Future<int> _indexedPersonCount() async {
    final row = await store
        .customSelect(
            "SELECT COUNT(*) AS c FROM content_search WHERE type = 'person'")
        .getSingle();
    return row.read<int>('c');
  }

  /// Inserts person names into the global FTS index if absent. Self-heals DBs
  /// that loaded people before search indexing existed.
  Future<void> _ensureIndexed() async {
    if (await _indexedPersonCount() == 0 && await _personCount() > 0) {
      await store.customStatement(_indexSql);
    }
  }

  /// Indexes name, disambiguated title, and alternate names, so "Jehiel"
  /// finds the Ner also called Jehiel.
  static const String _indexSql =
      "INSERT INTO content_search(type, reference_id, text_content) "
      "SELECT 'person', id, display_title || CASE WHEN also_called IS NULL "
      "THEN '' ELSE ' ' || also_called END FROM bible_people";

  /// Idempotent: loads the dataset once and ensures it is searchable.
  Future<void> ensureLoaded() async {
    if (await _personCount() > 0) {
      await _ensureIndexed();
      return;
    }

    final raw = await rootBundle.loadString(assetPath);
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final books = (data['books'] as List).cast<String>();
    final people = data['people'] as List;
    final groups = data['groups'] as List;
    final events = data['events'] as List;

    // The asset links people by array position; DB ids are position + 1 so
    // family/participant links can be resolved without a lookup per row.
    int? personId(dynamic idx) => idx == null ? null : (idx as int) + 1;

    final personRows = <BiblePeopleCompanion>[];
    final partnerRows = <PersonPartnersCompanion>[];
    final personVerseRows = <PersonVersesCompanion>[];
    var partnerId = 0, personVerseId = 0;

    for (var i = 0; i < people.length; i++) {
      final p = people[i] as Map<String, dynamic>;
      final name = p['n'] as String;
      personRows.add(BiblePeopleCompanion(
        id: Value(i + 1),
        slug: Value(p['s'] as String),
        name: Value(name),
        displayTitle: Value((p['dt'] as String?) ?? name),
        gender: Value(p['g'] as String?),
        alsoCalled: Value(p['a'] as String?),
        birthYear: Value(p['by'] as int?),
        deathYear: Value(p['dy'] as int?),
        minYear: Value(p['mn'] as int?),
        maxYear: Value(p['mx'] as int?),
        fatherId: Value(personId(p['f'])),
        motherId: Value(personId(p['m'])),
        bio: Value(p['b'] as String?),
        verseCount: Value((p['v'] as List).length),
      ));
      for (final partner in (p['pa'] as List? ?? const [])) {
        partnerRows.add(PersonPartnersCompanion(
          id: Value(++partnerId),
          personId: Value(i + 1),
          partnerId: Value(personId(partner)!),
        ));
      }
      for (final r in (p['v'] as List)) {
        final ref = r as List;
        personVerseRows.add(PersonVersesCompanion(
          id: Value(++personVerseId),
          personId: Value(i + 1),
          bookName: Value(books[ref[0] as int]),
          chapter: Value(ref[1] as int),
          verse: Value(ref[2] as int),
        ));
      }
    }

    final groupRows = <PeopleGroupsCompanion>[];
    final memberRows = <PeopleGroupMembersCompanion>[];
    var groupId = 0, memberId = 0;
    for (final g in groups) {
      groupId++;
      groupRows.add(PeopleGroupsCompanion(
        id: Value(groupId),
        name: Value(g['n'] as String),
      ));
      for (final m in (g['me'] as List)) {
        memberRows.add(PeopleGroupMembersCompanion(
          id: Value(++memberId),
          groupId: Value(groupId),
          personId: Value(personId(m)!),
        ));
      }
    }

    final eventRows = <TimelineEventsCompanion>[];
    final participantRows = <EventParticipantsCompanion>[];
    final eventVerseRows = <EventVersesCompanion>[];
    var eventId = 0, participantId = 0, eventVerseId = 0;
    for (final e in events) {
      eventId++;
      eventRows.add(TimelineEventsCompanion(
        id: Value(eventId),
        title: Value(e['t'] as String),
        sortKey: Value((e['k'] as num?)?.toDouble()),
        startYear: Value(e['y'] as int?),
      ));
      for (final pt in (e['pt'] as List)) {
        participantRows.add(EventParticipantsCompanion(
          id: Value(++participantId),
          eventId: Value(eventId),
          personId: Value(personId(pt)!),
        ));
      }
      var ord = 0;
      for (final r in (e['v'] as List)) {
        final ref = r as List;
        eventVerseRows.add(EventVersesCompanion(
          id: Value(++eventVerseId),
          eventId: Value(eventId),
          ord: Value(ord++),
          bookName: Value(books[ref[0] as int]),
          chapter: Value(ref[1] as int),
          verse: Value(ref[2] as int),
        ));
      }
    }

    await store.batch((b) {
      b.insertAll(store.biblePeople, personRows);
      b.insertAll(store.personPartners, partnerRows);
      b.insertAll(store.personVerses, personVerseRows);
      b.insertAll(store.peopleGroups, groupRows);
      b.insertAll(store.peopleGroupMembers, memberRows);
      b.insertAll(store.timelineEvents, eventRows);
      b.insertAll(store.eventParticipants, participantRows);
      b.insertAll(store.eventVerses, eventVerseRows);
    });

    // Index person names into the global full-text search.
    await store.customStatement(_indexSql);
  }
}
