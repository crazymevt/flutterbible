import 'package:flutter/material.dart';
import '../../data/content_store.dart';

import 'chapter_navigation_footer.dart';

class VerseListView extends StatelessWidget {
  final List<Verse> verses;
  final Set<int> selectedVerses;
  final Map<int, String> savedHighlights;
  final ValueChanged<int> onVerseTap;
  final bool showFooter;

  const VerseListView({
    super.key,
    required this.verses,
    required this.selectedVerses,
    required this.savedHighlights,
    required this.onVerseTap,
    this.showFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      itemCount: verses.length + (showFooter ? 1 : 0),
      itemBuilder: (context, index) {
        if (showFooter && index == verses.length) {
          return const ChapterNavigationFooter();
        }
        final verse = verses[index];
        final isSelected = selectedVerses.contains(verse.verse);
        final highlightHex = savedHighlights[verse.verse];
        final highlightColor = highlightHex != null 
            ? Color(int.parse(highlightHex.replaceFirst('#', '0xFF'))) 
            : null;

        final bgColor = isSelected
            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5)
            : highlightColor?.withValues(alpha: 0.2);

        return ListTile(
          tileColor: bgColor,
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${verse.verse} ',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontFeatures: const [FontFeature.superscripts()],
                      ),
                ),
                TextSpan(
                  text: verse.textContent,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
              ],
            ),
          ),
          onTap: () => onVerseTap(verse.verse),
        );
    },
    );
  }
}
