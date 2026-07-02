import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app_state.dart';
import '../../app/content_providers.dart';
import '../../app/people_providers.dart';
import '../../app/reader_state.dart';
import '../../data/content_store.dart';
import '../common/breakpoints.dart';
import '../common/skeleton.dart';
import 'people_timeline_screen.dart';

/// Open [personId] in the People tool: the side panel on wide layouts, a
/// bottom sheet on phones.
void openPersonInPanel(BuildContext context, WidgetRef ref, int personId) {
  ref.read(selectedPersonProvider.notifier).select(personId);
  if (context.isWideLayout) {
    ref.read(activeToolProvider.notifier).openTool(ActiveTool.people);
  } else {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.sizeOf(context).height * 0.85,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: const PeoplePanel(),
      ),
    );
  }
}

/// Shows a person's profile in a modal bottom sheet, regardless of layout —
/// used from fullscreen surfaces (e.g. the timeline) where the docked side
/// panel would be hidden behind the route.
void showPersonDetailSheet(BuildContext context, WidgetRef ref, int personId) {
  ref.read(selectedPersonProvider.notifier).select(personId);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      // No timeline button here: this sheet is opened from the timeline, and a
      // second one would stack on top of the first.
      child: const PeoplePanel(showTimelineButton: false),
    ),
  );
}

/// Formats an ISO year for display: negative years are BC.
String formatIsoYear(int year) => year < 0 ? '${-year} BC' : 'AD $year';

/// Theographic people browser: shows who is mentioned in the current chapter,
/// searches all 3,000+ people, and drills into a person's family, biography,
/// timeline, and appearances.
class PeoplePanel extends ConsumerStatefulWidget {
  const PeoplePanel({super.key, this.showTimelineButton = true});

  /// Whether to show the header button that opens the fullscreen timeline.
  /// Hidden when this panel is itself a detail sheet opened *from* the
  /// timeline, so tapping it can't stack a second timeline on top.
  final bool showTimelineButton;

  @override
  ConsumerState<PeoplePanel> createState() => _PeoplePanelState();
}

class _PeoplePanelState extends ConsumerState<PeoplePanel> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(personSearchQueryProvider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPerson = ref.watch(selectedPersonProvider);
    final ready = ref.watch(peopleReadyProvider);

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (selectedPerson != null)
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            tooltip: 'Back to list',
                            visualDensity: VisualDensity.compact,
                            onPressed: () => ref
                                .read(selectedPersonProvider.notifier)
                                .select(null),
                          ),
                        Text(
                          'People',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (widget.showTimelineButton)
                          IconButton(
                            icon: const Icon(Icons.timeline),
                            tooltip: 'Timeline',
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PeopleTimelineScreen(),
                              ),
                            ),
                          ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: 'Close',
                          onPressed: () {
                            ref.read(activeToolProvider.notifier).close();
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search people (e.g. Aaron, Priscilla)…',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v) {
                    ref.read(personSearchQueryProvider.notifier).setQuery(v);
                    if (selectedPerson != null) {
                      ref.read(selectedPersonProvider.notifier).select(null);
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ready.when(
              loading: () => const SkeletonList(),
              error: (e, _) => Center(child: Text('Could not load people: $e')),
              data: (_) => selectedPerson != null
                  ? _PersonDetailView(personId: selectedPerson)
                  : const _PeopleListView(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Search results when a query is active, otherwise the people mentioned in
/// the chapter being read.
class _PeopleListView extends ConsumerWidget {
  const _PeopleListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(personSearchQueryProvider).trim();
    if (query.isEmpty) return const _PeopleInChapter();

    final results = ref.watch(personSearchResultsProvider);
    return results.when(
      loading: () => const SkeletonList(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (people) {
        if (people.isEmpty) {
          return Center(child: Text('No people matching "$query".'));
        }
        return ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, i) => _PersonTile(person: people[i]),
        );
      },
    );
  }
}

class _PersonTile extends ConsumerWidget {
  const _PersonTile({required this.person});

  final BiblePerson person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = <String>[
      if (person.alsoCalled != null) 'also called ${person.alsoCalled}',
      '${person.verseCount} ${person.verseCount == 1 ? 'verse' : 'verses'}',
    ];
    return ListTile(
      dense: true,
      title: Text(person.displayTitle),
      subtitle: Text(
        details.join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () => ref.read(selectedPersonProvider.notifier).select(person.id),
    );
  }
}

class _PeopleInChapter extends ConsumerWidget {
  const _PeopleInChapter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(selectedBookNameProvider);
    final chapter = ref.watch(selectedChapterProvider);
    final people = ref.watch(currentPassagePeopleProvider);
    return people.when(
      loading: () => const SkeletonList(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (list) {
        if (list.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'No people are tagged in $book $chapter.\n'
                'Search over 3,000 people of the Bible above.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, i) {
            if (i == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'In $book $chapter',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              );
            }
            final p = list[i - 1];
            return ListTile(
              dense: true,
              title: Text(p.displayTitle),
              subtitle: Text(
                'v. ${p.verses.join(', ')}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () =>
                  ref.read(selectedPersonProvider.notifier).select(p.id),
            );
          },
        );
      },
    );
  }
}

class _PersonDetailView extends ConsumerWidget {
  const _PersonDetailView({required this.personId});

  final int personId;

  void _goToVerse(
    BuildContext context,
    WidgetRef ref,
    String bookName,
    int chapter,
    int verse,
  ) {
    ref.read(selectedBookNameProvider.notifier).set(bookName);
    ref.read(selectedChapterProvider.notifier).set(chapter);
    ref.read(targetVerseToScrollProvider.notifier).set(verse);
    ref.read(selectedVersesProvider.notifier).clear();
    ref.read(selectedVersesProvider.notifier).toggle(verse);
    ref.read(navigationControllerProvider).recordHistory(verse: verse);
    if (MediaQuery.sizeOf(context).width <= Breakpoints.compact) {
      Navigator.of(context).maybePop();
    }
  }

  String _lifeYears(BiblePerson p) {
    final birth = p.birthYear, death = p.deathYear;
    if (birth != null && death != null) {
      return '${formatIsoYear(birth)} – ${formatIsoYear(death)}';
    }
    if (birth != null) return 'born ${formatIsoYear(birth)}';
    if (death != null) return 'died ${formatIsoYear(death)}';
    return '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(personDetailProvider(personId));
    final scheme = Theme.of(context).colorScheme;
    return detail.when(
      loading: () => const SkeletonList(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (d) {
        if (d == null) return const SizedBox.shrink();
        final p = d.person;
        final years = _lifeYears(p);
        final subtitle = [
          if (p.gender != null) p.gender!,
          if (years.isNotEmpty) years,
          if (d.groups.isNotEmpty) d.groups.join(', '),
        ].join(' · ');

        // SelectionArea so the bio and details can be copied; chips and
        // tiles inside stay tappable.
        return SelectionArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              Text(
                p.displayTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                ),
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              if (p.alsoCalled != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'Also called ${p.alsoCalled}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              _FamilySection(detail: d),
              if (p.bio != null) ...[
                const _SectionHeader('Biography — Easton\'s Bible Dictionary'),
                Text(p.bio!, style: Theme.of(context).textTheme.bodyMedium),
              ],
              if (d.events.isNotEmpty) ...[
                const _SectionHeader('Timeline'),
                for (final e in d.events)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(e.title),
                    subtitle: e.startYear == null
                        ? null
                        : Text(formatIsoYear(e.startYear!)),
                    trailing: e.bookName == null
                        ? null
                        : Text(
                            '${e.bookName} ${e.chapter}:${e.verse}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.primary),
                          ),
                    onTap: e.bookName == null
                        ? null
                        : () => _goToVerse(
                            context,
                            ref,
                            e.bookName!,
                            e.chapter!,
                            e.verse!,
                          ),
                  ),
              ],
              if (d.verses.isNotEmpty) ...[
                _SectionHeader(
                  'Appears in ${d.verses.length} '
                  '${d.verses.length == 1 ? 'verse' : 'verses'}',
                ),
                ..._verseGroups(context, ref, d.verses),
              ],
            ],
          ),
        );
      },
    );
  }

  /// One collapsed tile per book, expanding to that book's verse chips — keeps
  /// heavily-mentioned people (Aaron: 331 verses) scannable.
  List<Widget> _verseGroups(
    BuildContext context,
    WidgetRef ref,
    List<PersonVerse> verses,
  ) {
    final byBook = <String, List<PersonVerse>>{};
    for (final v in verses) {
      byBook.putIfAbsent(v.bookName, () => []).add(v);
    }
    return [
      for (final entry in byBook.entries)
        ExpansionTile(
          dense: true,
          tilePadding: EdgeInsets.zero,
          title: Text('${entry.key} (${entry.value.length})'),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final v in entry.value)
                    ActionChip(
                      visualDensity: VisualDensity.compact,
                      label: Text('${v.chapter}:${v.verse}'),
                      onPressed: () => _goToVerse(
                        context,
                        ref,
                        v.bookName,
                        v.chapter,
                        v.verse,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
    ];
  }
}

class _FamilySection extends ConsumerWidget {
  const _FamilySection({required this.detail});

  final PersonDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = <(String, List<BiblePerson>)>[
      if (detail.father != null) ('Father', [detail.father!]),
      if (detail.mother != null) ('Mother', [detail.mother!]),
      if (detail.partners.isNotEmpty)
        (detail.partners.length == 1 ? 'Spouse' : 'Spouses', detail.partners),
      if (detail.siblings.isNotEmpty) ('Siblings', detail.siblings),
      if (detail.children.isNotEmpty) ('Children', detail.children),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader('Family'),
        for (final (label, people) in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 72,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final p in people)
                        ActionChip(
                          visualDensity: VisualDensity.compact,
                          label: Text(p.displayTitle),
                          onPressed: () => ref
                              .read(selectedPersonProvider.notifier)
                              .select(p.id),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
