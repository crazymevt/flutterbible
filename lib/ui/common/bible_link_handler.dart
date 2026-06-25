import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/content_providers.dart';
import '../../app/app_state.dart';
import '../../app/reader_state.dart';
import '../../data/mybible_book_map.dart';
import '../../data/logging.dart';

/// Handles a tap on a Bible-reference link embedded in HTML content (dictionary,
/// commentary, etc.).
///
/// Parses MyBible-style references such as `b/?b=10&c=1&v=1` or `B:10 1 1`,
/// navigates the reader there, records history, and closes the active tool
/// panel. Returns `true` so the surrounding `HtmlWidget` does NOT fall back to
/// launching the URL externally — these internal schemes are "unsupported" by
/// the OS launcher and would otherwise error.
bool handleBibleRefTap(WidgetRef ref, BuildContext context, String url) {
  try {
    int? b, c, v;

    // Try query parameters first (e.g. b/?b=10&c=1&v=1)
    final uri = Uri.tryParse(url);
    if (uri != null &&
        (uri.queryParameters.containsKey('b') ||
            uri.queryParameters.containsKey('B'))) {
      b = int.tryParse(
        uri.queryParameters['b'] ?? uri.queryParameters['B'] ?? '',
      );
      c = int.tryParse(
        uri.queryParameters['c'] ?? uri.queryParameters['C'] ?? '',
      );
      v = int.tryParse(
        uri.queryParameters['v'] ?? uri.queryParameters['V'] ?? '',
      );
    } else {
      // Try generic format with any non-digit delimiters
      // (e.g. b:10/1/1 or B: 10 1 1)
      final match = RegExp(
        r'^(?:b|bible):[^\d]*(\d+)(?:[^\d]+(\d+))?(?:[^\d]+(\d+))?',
        caseSensitive: false,
      ).firstMatch(url);
      if (match != null) {
        b = match.group(1) != null ? int.tryParse(match.group(1)!) : null;
        c = match.group(2) != null ? int.tryParse(match.group(2)!) : null;
        v = match.group(3) != null ? int.tryParse(match.group(3)!) : null;
      }
    }

    if (b != null) {
      final bookName =
          mybibleBookMap[b] ?? mybibleBookMap[b * 10]; // Fallback to * 10
      if (bookName != null) {
        ref.read(selectedBookNameProvider.notifier).set(bookName);
        if (c != null && c > 0) {
          ref.read(selectedChapterProvider.notifier).set(c);
        }
        if (v != null && v > 0) {
          ref.read(selectedVersesProvider.notifier).clear();
          ref.read(selectedVersesProvider.notifier).toggle(v);
          ref.read(targetVerseToScrollProvider.notifier).set(v);
        }

        // Record history
        ref.read(navigationControllerProvider).recordHistory(verse: v);

        // Also close the tool panel so they can read the verse
        ref.read(activeToolProvider.notifier).close();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown book number: $b from $url')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not parse link: $url')),
      );
    }
  } catch (e, stack) {
    logError(e, stack, context: 'Bible ref link tap: $url');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error parsing url $url: $e')),
    );
  }
  return true;
}
