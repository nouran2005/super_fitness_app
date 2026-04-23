import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
    this.showSeeAll = true,
  });

  final String title;
  final VoidCallback? onSeeAllTap;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.025,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          if (showSeeAll)
            InkWell(
              onTap: onSeeAllTap ?? () {},
              child: Text(
                LocaleKeys.seeAll.tr(),
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: const Color(0xFFFF4100),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFFF4100),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
