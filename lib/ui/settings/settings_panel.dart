import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/app_state.dart';

class SettingsPanel extends ConsumerWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final appColorTheme = ref.watch(appColorThemeProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildThemeModeSelector(context, ref, themeMode),
          const SizedBox(height: 24),
          _buildColorThemeSelector(context, ref, appColorTheme),
        ],
      ),
    );
  }

  Widget _buildThemeModeSelector(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Theme Mode', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(
              value: ThemeMode.system,
              icon: Icon(Icons.brightness_auto),
              label: Text('System'),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              icon: Icon(Icons.light_mode),
              label: Text('Light'),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              icon: Icon(Icons.dark_mode),
              label: Text('Dark'),
            ),
          ],
          selected: {currentMode},
          onSelectionChanged: (Set<ThemeMode> newSelection) {
            ref.read(themeModeProvider.notifier).setMode(newSelection.first);
          },
        ),
      ],
    );
  }

  Widget _buildColorThemeSelector(BuildContext context, WidgetRef ref, String currentTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Scheme', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        RadioListTile<String>(
          title: const Text('Default Purple'),
          subtitle: const Text('Standard Material layout'),
          value: 'default',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('Soft Indiglow'),
          subtitle: const Text('Warm indigo and soft blues'),
          value: 'softIndiglow',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('Modern Indigo'),
          subtitle: const Text('Clean surfaces with a confident indigo accent'),
          value: 'modernIndigo',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('Quiet Sage'),
          subtitle: const Text('Muted sage-green and stone'),
          value: 'quietSage',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('Onyx'),
          subtitle: const Text('Neutral graphite surfaces with calm teal accent'),
          value: 'onyx',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text('Ocean'),
          subtitle: const Text('Deep sea blue and sky accent'),
          value: 'ocean',
          groupValue: currentTheme,
          onChanged: (val) {
            if (val != null) {
              ref.read(appColorThemeProvider.notifier).setTheme(val);
            }
          },
        ),
      ],
    );
  }
}
