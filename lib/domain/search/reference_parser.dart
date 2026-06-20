import 'package:study_bible/data/content_store.dart';
import 'package:collection/collection.dart';

class ParsedReference {
  final Book book;
  final int chapter;
  final int? verse;

  ParsedReference({
    required this.book,
    required this.chapter,
    this.verse,
  });
}

class ReferenceParser {
  // Matches e.g. "John 3", "Jn 3:16", "1 John 2", "1 Jn 2:3", "Song of Solomon 2:1"
  static final _regex = RegExp(r'^(.+?)\s+(\d+)(?:\s*:\s*(\d+))?$');

  static ParsedReference? parse(String query, List<Book> availableBooks) {
    final match = _regex.firstMatch(query.trim());
    if (match == null) return null;

    final bookInput = match.group(1)?.trim().toLowerCase() ?? '';
    final chapterStr = match.group(2);
    final verseStr = match.group(3);

    if (chapterStr == null) return null;
    final chapter = int.tryParse(chapterStr);
    if (chapter == null || chapter <= 0) return null;

    int? verse;
    if (verseStr != null) {
      verse = int.tryParse(verseStr);
      if (verse != null && verse <= 0) verse = null;
    }

    final book = _findBook(bookInput, availableBooks);
    if (book == null) return null;

    return ParsedReference(book: book, chapter: chapter, verse: verse);
  }

  static Book? _findBook(String input, List<Book> books) {
    // 1. Exact match (case insensitive)
    var exact = books.firstWhereOrNull((b) => b.name.toLowerCase() == input);
    if (exact != null) return exact;

    // Normalize input (e.g. "1 jn" -> "1john", "song of solomon" -> "songofsolomon")
    final normalizedInput = input.replaceAll(' ', '');

    // 2. Exact match on normalized names
    var normalizedExact = books.firstWhereOrNull((b) {
      final normName = b.name.toLowerCase().replaceAll(' ', '');
      return normName == normalizedInput;
    });
    if (normalizedExact != null) return normalizedExact;

    // 3. Prefix match
    var prefixMatch = books.firstWhereOrNull((b) {
      final normName = b.name.toLowerCase().replaceAll(' ', '');
      return normName.startsWith(normalizedInput);
    });
    if (prefixMatch != null) return prefixMatch;

    return null;
  }
}
