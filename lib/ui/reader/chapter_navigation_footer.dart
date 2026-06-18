import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/content_providers.dart';

class ChapterNavigationFooter extends ConsumerWidget {
  const ChapterNavigationFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
            onPressed: () {
              ref.read(navigationControllerProvider).previousChapter();
            },
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(navigationControllerProvider).nextChapter();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Next'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
