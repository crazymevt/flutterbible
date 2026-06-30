import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_drawer.dart';
import 'journals_list_panel.dart';
import 'journal_editor_panel.dart';
import 'prayer_tracker_panel.dart';
import 'action_items_panel.dart';
import '../common/search_title_bar.dart';
import '../common/breakpoints.dart';
import '../common/sync_button.dart';

class JournalsPrayersScreen extends ConsumerStatefulWidget {
  const JournalsPrayersScreen({super.key});

  @override
  ConsumerState<JournalsPrayersScreen> createState() =>
      _JournalsPrayersScreenState();
}

class _JournalsPrayersScreenState extends ConsumerState<JournalsPrayersScreen> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > Breakpoints.compact;

    if (isDesktop) {
      return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          centerTitle: true,
          title: const SearchTitleBar(),
          actions: const [SyncButton()],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: _buildPanelCard(
                context,
                title: 'Journal Entries',
                icon: Icons.book,
                child: const JournalsListPanel(),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildPanelCard(
                context,
                title: 'Editor',
                icon: Icons.edit_document,
                child: const JournalEditorPanel(),
              ),
            ),
            Expanded(
              flex: 3,
              child: _buildTabbedCard(
                context,
                tabs: const [
                  Tab(text: 'Prayers'),
                  Tab(text: 'Actions'),
                ],
                views: const [PrayerTrackerPanel(), ActionItemsPanel()],
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          centerTitle: true,
          title: const SearchTitleBar(),
          actions: const [SyncButton()],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Journals'),
              Tab(text: 'Prayers'),
              Tab(text: 'Actions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            JournalsListPanel(),
            PrayerTrackerPanel(),
            ActionItemsPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  /// Like [_buildPanelCard] but the header is a [TabBar] that switches between
  /// the supplied [views] — used to fit Prayers and Actions into one column.
  Widget _buildTabbedCard(
    BuildContext context, {
    required List<Tab> tabs,
    required List<Widget> views,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                border: Border(
                  bottom: BorderSide(
                    color:
                        theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: TabBar(tabs: tabs),
            ),
            Expanded(child: TabBarView(children: views)),
          ],
        ),
      ),
    );
  }
}
