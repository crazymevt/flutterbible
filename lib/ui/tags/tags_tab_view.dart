import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/tag_providers.dart';
import 'tag_results_list.dart';
import 'tag_palette.dart';
import '../common/empty_state.dart';
import '../common/skeleton.dart';

class TagsTabView extends ConsumerStatefulWidget {
  const TagsTabView({super.key});

  @override
  ConsumerState<TagsTabView> createState() => _TagsTabViewState();
}

class _TagsTabViewState extends ConsumerState<TagsTabView> {
  String? _selectedTagId;
  String? _selectedTagName;
  // Normalised hex to filter the tag cloud by, or null for "all colours".
  String? _filterColor;

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
                  tooltip: 'Back to all tags',
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
          return const EmptyState(
            icon: Icons.label_outline,
            title: 'No tags yet',
            message: 'Select verses or notes to add your first tag.',
          );
        }

        // Colours actually in use, in palette order, for the filter row.
        final usedColors = <String>{
          for (final t in tags)
            if (normalizeTagHex(t.colorHex) != null) normalizeTagHex(t.colorHex)!,
        };
        // Ignore a stale filter if that colour no longer exists (don't mutate
        // state during build; the field self-corrects on the next tap).
        final effectiveFilter =
            (_filterColor != null && usedColors.contains(_filterColor))
                ? _filterColor
                : null;

        final visibleTags = effectiveFilter == null
            ? tags
            : tags
                .where((t) => normalizeTagHex(t.colorHex) == effectiveFilter)
                .toList();

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
              if (usedColors.length > 1) ...[
                const SizedBox(height: 12),
                _ColorFilterRow(
                  usedColors: usedColors,
                  selected: effectiveFilter,
                  onSelected: (hex) => setState(() => _filterColor = hex),
                ),
              ],
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: visibleTags.map((t) {
                  final style = tagChipStyle(context, t.colorHex);
                  return ActionChip(
                    label: Text('#${t.name}',
                        style: TextStyle(color: style.foreground)),
                    backgroundColor: style.background,
                    side: BorderSide(color: style.border),
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
      loading: () => const SkeletonList(),
      error: (e, _) => const EmptyState(
        icon: Icons.error_outline,
        title: 'Couldn\'t load tags',
      ),
    );
  }
}

/// A row of colour dots to filter the tag cloud, with a leading "All" option.
/// Only shows colours that are actually in use (passed via [usedColors], a set
/// of normalised hexes).
class _ColorFilterRow extends StatelessWidget {
  final Set<String> usedColors;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _ColorFilterRow({
    required this.usedColors,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget dot({
      required Color color,
      required bool isSelected,
      required VoidCallback onTap,
      required String tooltip,
      IconData? icon,
    }) {
      return Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? scheme.onSurface : scheme.outlineVariant,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: icon != null
                ? Icon(icon, size: 16, color: scheme.onSurfaceVariant)
                : (isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null),
          ),
        ),
      );
    }

    // Palette order, restricted to in-use colours.
    final ordered = [
      for (final s in kTagPalette)
        if (usedColors.contains(normalizeTagHex(s.hex))) s,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        dot(
          color: scheme.surfaceContainerHighest,
          isSelected: selected == null,
          onTap: () => onSelected(null),
          tooltip: 'All colours',
          icon: selected == null ? null : Icons.done_all,
        ),
        for (final s in ordered)
          dot(
            color: s.color,
            isSelected: selected == normalizeTagHex(s.hex),
            onTap: () => onSelected(normalizeTagHex(s.hex)),
            tooltip: s.name,
          ),
      ],
    );
  }
}
