import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/shared_prefs.dart';
import '../app_drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    final showDashboardOnStart = prefs.getBool('showDashboardOnStart') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Show Dashboard on Startup'),
            subtitle: const Text('Launch directly to the dashboard instead of the reader'),
            value: showDashboardOnStart,
            onChanged: (value) {
              ref.read(sharedPreferencesProvider).setBool('showDashboardOnStart', value);
              // Force rebuild to reflect the new setting
              // Actually, sharedPreferencesProvider doesn't notify on its own when values change
              // unless we use a provider for the specific setting.
              // For a simple settings page, forcing a rebuild of the consumer by invalidating the provider is an option,
              // or using a Stateful widget to update local state.
              // Let's invalidate sharedPreferencesProvider to trigger a rebuild.
              ref.invalidate(sharedPreferencesProvider);
            },
          ),
        ],
      ),
    );
  }
}
