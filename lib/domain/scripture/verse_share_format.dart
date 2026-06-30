// Pure-Dart model + formatter for rendering selected verses to plain text when
// copying or sharing. No Flutter or IO imports — see CLAUDE.md (domain layer).

/// Where the scripture reference (e.g. "John 3:16") sits relative to the verse
/// text in copied/shared output.
enum VerseReferencePosition {
  /// Reference on the first line, verses below — the classic study layout.
  top,

  /// Verses first, reference as a trailing citation ("— John 3:16") — the
  /// layout people expect when quoting scripture in a message or post.
  bottom;

  static VerseReferencePosition fromName(String? name) {
    return VerseReferencePosition.values.firstWhere(
      (p) => p.name == name,
      orElse: () => VerseReferencePosition.top,
    );
  }
}

/// User preference for how selected verses are rendered for copy/share. Pure
/// data; persisted by `verseShareFormatProvider` and consumed by the verse
/// action bar.
class VerseShareFormat {
  /// Prefix each verse with its number (e.g. "16 For God so loved…").
  final bool includeVerseNumbers;

  /// Append the source version's abbreviation to the reference
  /// (e.g. "John 3:16 (ESV)").
  final bool includeVersionAbbreviation;

  final VerseReferencePosition referencePosition;

  const VerseShareFormat({
    this.includeVerseNumbers = true,
    this.includeVersionAbbreviation = false,
    this.referencePosition = VerseReferencePosition.top,
  });

  VerseShareFormat copyWith({
    bool? includeVerseNumbers,
    bool? includeVersionAbbreviation,
    VerseReferencePosition? referencePosition,
  }) {
    return VerseShareFormat(
      includeVerseNumbers: includeVerseNumbers ?? this.includeVerseNumbers,
      includeVersionAbbreviation:
          includeVersionAbbreviation ?? this.includeVersionAbbreviation,
      referencePosition: referencePosition ?? this.referencePosition,
    );
  }
}

/// One selected verse: its number and already-cleaned plain text (markup and
/// Strong's/footnote tags stripped by the caller — see
/// [[verse-textcontent-has-markup]]).
typedef ShareVerse = ({int number, String text});

/// Arranges selected verses into a plain-text block for copy/share. Stateless;
/// all inputs are passed in so it stays unit-testable in pure Dart.
class VerseShareFormatter {
  /// Collapses a sorted list of verse numbers into a compact range string:
  /// `[1, 2, 3, 5]` → `"1-3, 5"`.
  static String formatVerseRange(List<int> verses) {
    if (verses.isEmpty) return '';
    final sorted = verses.toList()..sort();
    final parts = <String>[];
    var start = sorted.first;
    var end = sorted.first;
    for (var i = 1; i < sorted.length; i++) {
      if (sorted[i] == end + 1) {
        end = sorted[i];
      } else {
        parts.add(start == end ? '$start' : '$start-$end');
        start = sorted[i];
        end = sorted[i];
      }
    }
    parts.add(start == end ? '$start' : '$start-$end');
    return parts.join(', ');
  }

  /// Builds the reference line, e.g. `"John 3:16, 17"` or, when
  /// [versionAbbreviation] is supplied, `"John 3:16, 17 (ESV)"`.
  static String reference({
    required String bookName,
    required int chapter,
    required List<int> verseNumbers,
    String? versionAbbreviation,
  }) {
    final range = formatVerseRange(verseNumbers);
    final base = range.isEmpty ? '$bookName $chapter' : '$bookName $chapter:$range';
    final abbr = versionAbbreviation?.trim();
    if (abbr == null || abbr.isEmpty) return base;
    return '$base ($abbr)';
  }

  /// Renders [verses] to a plain-text block per [format].
  static String format({
    required String bookName,
    required int chapter,
    required List<ShareVerse> verses,
    String? versionAbbreviation,
    VerseShareFormat format = const VerseShareFormat(),
  }) {
    if (verses.isEmpty) return '';
    final sorted = verses.toList()..sort((a, b) => a.number.compareTo(b.number));

    final ref = reference(
      bookName: bookName,
      chapter: chapter,
      verseNumbers: [for (final v in sorted) v.number],
      versionAbbreviation:
          format.includeVersionAbbreviation ? versionAbbreviation : null,
    );

    final String body;
    if (format.includeVerseNumbers) {
      // One verse per line, number-prefixed — readable for multi-verse study.
      body = [for (final v in sorted) '${v.number} ${v.text}'.trim()].join('\n');
    } else {
      // Flow the verse texts into a single quotable paragraph.
      body = sorted.map((v) => v.text.trim()).join(' ');
    }

    switch (format.referencePosition) {
      case VerseReferencePosition.top:
        return '$ref\n$body';
      case VerseReferencePosition.bottom:
        return '$body\n— $ref';
    }
  }
}
