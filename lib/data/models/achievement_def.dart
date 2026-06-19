import 'package:flutter/material.dart';

class AchievementDef {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const AchievementDef({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const List<AchievementDef> allAchievements = [
  AchievementDef(
    id: 'first_chapter',
    name: 'First Step',
    description: 'Read your first chapter.',
    icon: Icons.auto_awesome,
    color: Colors.blue,
  ),
  AchievementDef(
    id: '5_chapters',
    name: 'Getting Started',
    description: 'Read 5 chapters.',
    icon: Icons.star_half,
    color: Colors.lightGreen,
  ),
  AchievementDef(
    id: '10_chapters',
    name: 'On a Roll',
    description: 'Read 10 chapters.',
    icon: Icons.star,
    color: Colors.green,
  ),
  AchievementDef(
    id: 'ot_completed',
    name: 'Old Testament Scholar',
    description: 'Read the entire Old Testament.',
    icon: Icons.menu_book,
    color: Colors.amber,
  ),
  AchievementDef(
    id: 'nt_completed',
    name: 'New Testament Scholar',
    description: 'Read the entire New Testament.',
    icon: Icons.import_contacts,
    color: Colors.orange,
  ),
  AchievementDef(
    id: 'bible_completed',
    name: 'Bible Scholar',
    description: 'Read the entire Bible.',
    icon: Icons.workspace_premium,
    color: Colors.purple,
  ),
];
