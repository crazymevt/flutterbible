import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Sanity checks over the real bundled theographic dataset, so a bad ETL run
/// (scripts/build_theographic.dart) fails CI instead of surfacing as broken
/// family links or out-of-range verse references in the People panel.
void main() {
  late Map<String, dynamic> data;
  late List books;
  late List people;
  late List events;

  setUpAll(() {
    final raw = File('assets/data/theographic.json').readAsStringSync();
    data = jsonDecode(raw) as Map<String, dynamic>;
    books = data['books'] as List;
    people = data['people'] as List;
    events = data['events'] as List;
  });

  test('has the full canon and a substantial dataset', () {
    expect(books.length, 66);
    expect(books.first, 'Genesis');
    expect(books.last, 'Revelation');
    expect(people.length, greaterThan(3000));
    expect(events.length, greaterThan(400));
    expect((data['groups'] as List), isNotEmpty);
  });

  test('every person link and verse ref is in range', () {
    void expectValidRef(dynamic r, String context) {
      final ref = r as List;
      expect(ref.length, 3, reason: context);
      expect(ref[0], inInclusiveRange(0, 65), reason: context);
      expect(ref[1], greaterThan(0), reason: context);
      expect(ref[2], greaterThan(0), reason: context);
    }

    for (final p in people.cast<Map<String, dynamic>>()) {
      final who = p['s'];
      expect(p['n'], isNotEmpty, reason: 'person $who');
      for (final key in ['f', 'm']) {
        if (p[key] != null) {
          expect(p[key], inInclusiveRange(0, people.length - 1),
              reason: 'person $who $key');
        }
      }
      for (final partner in (p['pa'] as List? ?? const [])) {
        expect(partner, inInclusiveRange(0, people.length - 1),
            reason: 'person $who partner');
      }
      for (final r in p['v'] as List) {
        expectValidRef(r, 'person $who verse');
      }
    }
    for (final e in events.cast<Map<String, dynamic>>()) {
      for (final pt in e['pt'] as List) {
        expect(pt, inInclusiveRange(0, people.length - 1),
            reason: 'event "${e['t']}" participant');
      }
      for (final r in e['v'] as List) {
        expectValidRef(r, 'event "${e['t']}" verse');
      }
    }
  });

  test('Aaron is intact: family, bio, and Exodus references', () {
    final aaron = people
        .cast<Map<String, dynamic>>()
        .firstWhere((p) => p['s'] == 'aaron_1');
    expect(aaron['n'], 'Aaron');
    expect(aaron['f'], isNotNull);
    expect(people[aaron['f'] as int]['n'], 'Amram');
    expect(aaron['pa'], isNotEmpty);
    expect(aaron['b'], contains('eldest son of Amram'));
    // Markdown links must be reduced to their display text.
    expect(aaron['b'], isNot(contains('](')));
    // Exodus 4:14 is Aaron's first mention.
    expect((aaron['v'] as List).first, [1, 4, 14]);
  });

  test('events are in chronological order and start at creation', () {
    final first = events.first as Map<String, dynamic>;
    expect(first['t'], contains('Creation'));
    num? last;
    for (final e in events.cast<Map<String, dynamic>>()) {
      final k = e['k'] as num?;
      if (k == null) continue;
      if (last != null) {
        expect(k, greaterThanOrEqualTo(last),
            reason: 'event "${e['t']}" out of order');
      }
      last = k;
    }
  });
}
