import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';

class AppSectionDestination {
  const AppSectionDestination({
    required this.label,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  final String label;
  final String iconPath;
  final String title;
  final String subtitle;
}

const List<AppSectionDestination> appSectionDestinations = [
  AppSectionDestination(
    label: 'Explore',
    iconPath: Assets.imagesHome,
    title: 'Explore',
    subtitle: 'Discover classes, plans, and fresh ideas for your next session.',
  ),
  AppSectionDestination(
    label: 'Chat',
    iconPath: Assets.imagesChat,
    title: 'Chat',
    subtitle: 'Keep your coaching and nutrition conversations in one place.',
  ),
  AppSectionDestination(
    label: 'Workout',
    iconPath: Assets.imagesWorkout,
    title: 'Workout',
    subtitle: 'Jump into your active routines and track progress from here.',
  ),
  AppSectionDestination(
    label: 'Profile',
    iconPath: Assets.imagesProfile,
    title: 'Profile',
    subtitle: 'Manage your goals, preferences, and account details.',
  ),
];
