import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ProfileSelectionTile extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileSelectionTile({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "(${LocaleKeys.tapToEdit.tr()})",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.primary,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: mq * 0.02),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: mq * 0.04,
              vertical: mq * 0.025,
            ),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
