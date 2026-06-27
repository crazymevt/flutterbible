import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import '../common/breakpoints.dart';

class HelpTopic {
  final String title;
  final String assetPath;
  final IconData icon;

  const HelpTopic({
    required this.title,
    required this.assetPath,
    required this.icon,
  });
}

const _topics = [
  HelpTopic(
    title: 'Welcome',
    assetPath: 'assets/help/welcome.md',
    icon: Icons.waving_hand_outlined,
  ),
  HelpTopic(
    title: 'Reader',
    assetPath: 'assets/help/reader.md',
    icon: Icons.menu_book_rounded,
  ),
  HelpTopic(
    title: 'Search',
    assetPath: 'assets/help/search.md',
    icon: Icons.search,
  ),
  HelpTopic(
    title: 'Journals',
    assetPath: 'assets/help/journals.md',
    icon: Icons.edit_document,
  ),
  HelpTopic(
    title: 'Study Tools',
    assetPath: 'assets/help/tools.md',
    icon: Icons.view_sidebar,
  ),
  HelpTopic(
    title: 'Sermons',
    assetPath: 'assets/help/sermons.md',
    icon: Icons.co_present,
  ),
  HelpTopic(
    title: 'Content Manager',
    assetPath: 'assets/help/content_manager.md',
    icon: Icons.cloud_download,
  ),
  HelpTopic(
    title: 'Backup & Restore',
    assetPath: 'assets/help/backup.md',
    icon: Icons.backup,
  ),
];

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  HelpTopic _selectedTopic = _topics.first;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width > Breakpoints.compact;

    if (isDesktop) {
      return Scaffold(
        appBar: AppBar(title: const Text('Help Center')),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: _topics.length,
                itemBuilder: (context, index) {
                  final topic = _topics[index];
                  final isSelected = _selectedTopic == topic;
                  return ListTile(
                    leading: Icon(topic.icon, color: isSelected ? theme.colorScheme.primary : null),
                    title: Text(
                      topic.title,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.colorScheme.primary : null,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: theme.colorScheme.primaryContainer,
                    onTap: () {
                      setState(() {
                        _selectedTopic = topic;
                      });
                    },
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _HelpArticle(topic: _selectedTopic),
            ),
          ],
        ),
      );
    }

    // Mobile layout
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: ListView.builder(
        itemCount: _topics.length,
        itemBuilder: (context, index) {
          final topic = _topics[index];
          return ListTile(
            leading: Icon(topic.icon),
            title: Text(topic.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _HelpDetailScreen(topic: topic),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HelpDetailScreen extends StatelessWidget {
  final HelpTopic topic;
  const _HelpDetailScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: _HelpArticle(topic: topic),
    );
  }
}

class _HelpArticle extends StatelessWidget {
  final HelpTopic topic;
  const _HelpArticle({required this.topic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(topic.assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading help topic: ${snapshot.error}'));
        }

        final content = snapshot.data ?? 'No content found.';
        return Markdown(
          data: content,
          selectable: true,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            p: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            h1: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            h2: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
