import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app_state.dart';
import '../app/version.dart';
import 'whats_new_dialog.dart';

import 'settings/settings_screen.dart';
import 'help/help_screen.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentModule = ref.watch(appModuleProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Study Bible',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final themeMode = ref.watch(themeModeProvider);
                        IconData icon;
                        switch (themeMode) {
                          case ThemeMode.light:
                            icon = Icons.light_mode;
                            break;
                          case ThemeMode.dark:
                            icon = Icons.dark_mode;
                            break;
                          case ThemeMode.system:
                            icon = Icons.brightness_auto;
                            break;
                        }
                        return IconButton(
                          icon: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
                          tooltip: 'Toggle Theme',
                          onPressed: () {
                            final notifier = ref.read(themeModeProvider.notifier);
                            if (themeMode == ThemeMode.light) {
                              notifier.setMode(ThemeMode.dark);
                            } else if (themeMode == ThemeMode.dark) {
                              notifier.setMode(ThemeMode.system);
                            } else {
                              notifier.setMode(ThemeMode.light);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Bible Reader'),
            selected: currentModule == AppModule.reader,
            onTap: () {
              ref.read(appModuleProvider.notifier).setModule(AppModule.reader);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Journals & Prayers'),
            selected: currentModule == AppModule.journalsPrayers,
            onTap: () {
              ref
                  .read(appModuleProvider.notifier)
                  .setModule(AppModule.journalsPrayers);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            selected: currentModule == AppModule.dashboard,
            onTap: () {
              ref
                  .read(appModuleProvider.notifier)
                  .setModule(AppModule.dashboard);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_download),
            title: const Text('Content Manager'),
            selected: currentModule == AppModule.contentManager,
            onTap: () {
              ref
                  .read(appModuleProvider.notifier)
                  .setModule(AppModule.contentManager);
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup & Restore'),
            selected: currentModule == AppModule.backupRestore,
            onTap: () {
              ref
                  .read(appModuleProvider.notifier)
                  .setModule(AppModule.backupRestore);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help Center'),
            onTap: () {
              Navigator.of(context).pop(); // close drawer
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const HelpScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop(); // close drawer
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(); // close drawer
              showDialog(
                context: context,
                builder: (context) => const WhatsNewDialog(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                'Version $appVersion ($buildNumber)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
