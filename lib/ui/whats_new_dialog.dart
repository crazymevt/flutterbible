import 'package:flutter/material.dart';
import '../app/version.dart';

class WhatsNewDialog extends StatelessWidget {
  const WhatsNewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.new_releases, color: Colors.blue),
          const SizedBox(width: 12),
          Text("What's New in $appVersion"),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeature(
              context,
              icon: Icons.track_changes,
              title: "Global Version Tracking",
              description: "App version is now prominently tracked and displayed in the drawer.",
            ),
            _buildFeature(
              context,
              icon: Icons.brightness_6,
              title: "Theme Switcher",
              description: "Easily toggle between light, dark, and system default themes straight from the App Drawer.",
            ),
            _buildFeature(
              context,
              icon: Icons.local_fire_department,
              title: "Fixed Streak Calculations",
              description: "Reading verses with the time tracker now correctly contributes to your daily streaks!",
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Awesome!'),
        ),
      ],
    );
  }

  Widget _buildFeature(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
