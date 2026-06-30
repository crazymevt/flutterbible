import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app_state.dart';
import '../../app/content_providers.dart';
import '../../app/reader_state.dart';
import '../../app/user_providers.dart';

/// The highlight swatch palette, mirroring the verse action bar, so the review
/// list can show a friendly colour name and a matching filter.
const _highlightSwatches = <({String hex, String name})>[
  (hex: '#FBE083', name: 'Yellow'),
  (hex: '#98E2C6', name: 'Green'),
  (hex: '#B5E2FA', name: 'Blue'),
  (hex: '#F4A8C4', name: 'Pink'),
];

Color? _parseHex(String hex) {
  final cleaned = hex.replaceAll('#', '').trim();
  if (cleaned.length != 6) return null;
  final value = int.tryParse(cleaned, radix: 16);
  if (value == null) return null;
  return Color(0xFF000000 | value);
}

String _nameForHex(String hex) {
  for (final s in _highlightSwatches) {
    if (s.hex.toLowerCase() == hex.toLowerCase()) return s.name;
  }
  return 'Highlight';
}

/// A browsable, canonically-ordered list of every highlight the user has made —
/// the "where did I mark that?" view. Tapping an entry jumps the reader to it.
class HighlightsPanel extends ConsumerStatefulWidget {
  const HighlightsPanel({super.key});

  @override
  ConsumerState<HighlightsPanel> createState() => _HighlightsPanelState();
}

class _HighlightsPanelState extends ConsumerState<HighlightsPanel> {
  String? _colorFilter; // hex, or null for "all"

  @override
  Widget build(BuildContext context) {
    final highlightsAsync = ref.watch(allHighlightsProvider);
    final bookOrder = ref.watch(primaryBookOrderProvider).value ?? const {};

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Highlights',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ref.read(activeToolProvider.notifier).close();
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildColorFilter(),
          const Divider(height: 1),
          Expanded(
            child: highlightsAsync.when(
              data: (highlights) {
                final filtered = _colorFilter == null
                    ? highlights
                    : highlights
                        .where((h) =>
                            h.colorHex.toLowerCase() ==
                            _colorFilter!.toLowerCase())
                        .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      _colorFilter == null
                          ? 'No highlights yet.'
                          : 'No ${_nameForHex(_colorFilter!).toLowerCase()} highlights.',
                    ),
                  );
                }

                final sorted = filtered.toList()
                  ..sort((a, b) {
                    final ao = bookOrder[a.bookName] ?? 1 << 20;
                    final bo = bookOrder[b.bookName] ?? 1 << 20;
                    if (ao != bo) return ao.compareTo(bo);
                    if (a.chapter != b.chapter) {
                      return a.chapter.compareTo(b.chapter);
                    }
                    return a.verse.compareTo(b.verse);
                  });

                return ListView.separated(
                  itemCount: sorted.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final h = sorted[index];
                    final color = _parseHex(h.colorHex);
                    return ListTile(
                      leading: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color ?? Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      title: Text(
                        '${h.bookName} ${h.chapter}:${h.verse}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_nameForHex(h.colorHex)),
                      onTap: () => _goTo(h.bookName, h.chapter, h.verse),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  const Center(child: Text('Error loading highlights')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: _colorFilter == null,
            onSelected: (_) => setState(() => _colorFilter = null),
          ),
          const SizedBox(width: 8),
          for (final s in _highlightSwatches) ...[
            ChoiceChip(
              avatar: CircleAvatar(backgroundColor: _parseHex(s.hex)),
              label: Text(s.name),
              selected: _colorFilter?.toLowerCase() == s.hex.toLowerCase(),
              onSelected: (_) => setState(() => _colorFilter = s.hex),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  void _goTo(String bookName, int chapter, int verse) {
    ref.read(selectedBookNameProvider.notifier).set(bookName);
    ref.read(selectedChapterProvider.notifier).set(chapter);
    ref.read(targetVerseToScrollProvider.notifier).set(verse);
    ref.read(selectedVersesProvider.notifier).clear();
    ref.read(selectedVersesProvider.notifier).toggle(verse);
    ref.read(navigationControllerProvider).recordHistory(verse: verse);

    ref.read(activeToolProvider.notifier).close();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
