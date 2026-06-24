/// A testament-scoped reader that yields the raw (still markup-bearing) entry
/// text at a positional versification slot.
///
/// Implemented by both the compressed [SwordZTextReader] (`zText`/`zText4`) and
/// the uncompressed [SwordRawTextReader] (`RawText`/`RawText4`) so the importer
/// can walk the versification without caring about the on-disk layout.
abstract interface class SwordVerseReader {
  /// The decoded entry text at testament-relative [index], or null when the
  /// slot is out of range or has zero length (a verse not present in this
  /// module — common for headings and gaps in the versification).
  String? entryAt(int index);

  /// Number of verse-index slots available.
  int get recordCount;
}
