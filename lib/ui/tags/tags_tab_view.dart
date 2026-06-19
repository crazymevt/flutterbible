import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/tag_providers.dart';
import 'tag_results_list.dart';

class TagsTabView extends ConsumerStatefulWidget {
  const TagsTabView({super.key});

  @override
  ConsumerState<TagsTabView> createState() => _TagsTabViewState();
}

class _TagsTabViewState extends ConsumerState<TagsTabView> {
  String? _selectedTagId;
  String? _selectedTagName;

  @override
  Widget build(BuildContext context) {
    if (_selectedTagId != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() {
                    _selectedTagId = null;
                    _selectedTagName = null;
                  }),
                ),
                Text(
                  'Results for #$_selectedTagName',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: TagResultsList(tagId: _selectedTagId!, tagName: _selectedTagName!),
          ),
        ],
      );
    }

    final allTagsAsync = ref.watch(allTagsProvider);

    return allTagsAsync.when(
      data: (tags) {
        if (tags.isEmpty) {
          return const Center(
            child: Text('You haven\'t created any tags yet.\nSelect verses or notes to add tags!'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Browse by Tag',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((t) {
                  return ActionChip(
                    label: Text('#${t.name}'),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    onPressed: () {
                      setState(() {
                        _selectedTagId = t.id;
                        _selectedTagName = t.name;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
