/// A search query with an optional leading testament scope.
///
/// A query may start with `ot:` or `nt:` (case-insensitive) to limit results to
/// Old- or New-Testament verses. The prefix is stripped off into [testament]
/// ('OT' / 'NT', or null when absent) and the remaining text becomes [terms].
class TestamentScopedQuery {
  /// 'OT', 'NT', or null when the query had no testament prefix.
  final String? testament;

  /// The search terms with any testament prefix removed, trimmed.
  final String terms;

  const TestamentScopedQuery({required this.testament, required this.terms});
}

final RegExp _testamentPrefix = RegExp(r'^(ot|nt):\s*', caseSensitive: false);

/// Splits an optional `ot:` / `nt:` scope off the front of [raw].
///
/// Only the colon form is recognised, so a plain search for a word like "ot"
/// is unaffected. Returns `testament: null` and the trimmed query when no
/// prefix is present.
TestamentScopedQuery parseTestamentScope(String raw) {
  final match = _testamentPrefix.firstMatch(raw.trimLeft());
  if (match == null) {
    return TestamentScopedQuery(testament: null, terms: raw.trim());
  }
  return TestamentScopedQuery(
    testament: match.group(1)!.toUpperCase(),
    terms: raw.trimLeft().substring(match.end).trim(),
  );
}
