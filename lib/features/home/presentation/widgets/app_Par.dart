import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.photoAsset,
  });

  final String userName;
  final String photoAsset;

  @override
  Widget build(BuildContext context) { 
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: AppColors.white,
                    ),
                    children: [
                      TextSpan(text: '${LocaleKeys.hi.tr()} '),
                      TextSpan(
                        text: '$userName ,',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  LocaleKeys.letsStartYourDay.tr(),
                  style: AppStyles.baloo18Medium.copyWith(
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: screenWidth * 0.06,
            backgroundColor: AppColors.grey,
            backgroundImage: AssetImage(photoAsset),
          ),
        ],
      ),
    );
  }
}
