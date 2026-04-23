import 'package:flutter/material.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class UpcomingFeatureDialog extends StatelessWidget {
  const UpcomingFeatureDialog({super.key, required this.featureName});

  final String featureName;

  static void show(BuildContext context, String featureName) {
    showDialog(
      context: context,
      builder: (context) => UpcomingFeatureDialog(featureName: featureName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.orange, size: 48),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.upcomingFeature.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.availableSoon.tr(args: [featureName.tr()]),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              LocaleKeys.gotIt.tr(),
              style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
