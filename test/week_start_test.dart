import 'package:flutter_test/flutter_test.dart';
import 'package:study_bible/app/app_state.dart';

void main() {
  group('startOfWeekFor', () {
    // 2026-06-29 is a Monday.
    final monday = DateTime(2026, 6, 29);
    final wednesday = DateTime(2026, 7, 1);
    final sunday = DateTime(2026, 7, 5);

    test('Monday start matches the original weekday-1 behaviour', () {
      expect(startOfWeekFor(wednesday, DateTime.monday), monday);
      expect(startOfWeekFor(monday, DateTime.monday), monday);
      expect(startOfWeekFor(sunday, DateTime.monday), monday);
    });

    test('Sunday start walks back to the prior Sunday', () {
      // The Sunday before the 29th is the 28th.
      expect(startOfWeekFor(wednesday, DateTime.sunday), DateTime(2026, 6, 28));
      expect(startOfWeekFor(sunday, DateTime.sunday), sunday);
    });

    test('a day equal to the chosen start returns itself', () {
      expect(startOfWeekFor(wednesday, DateTime.wednesday), wednesday);
    });
  });
}
