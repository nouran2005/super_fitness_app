import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoLaunchWidget extends StatelessWidget {
  const VideoLaunchWidget({super.key, required this.meal});
  final String meal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(meal);
        await launchUrl(url, mode: LaunchMode.externalApplication);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.play_arrow, color: Colors.white),
            SizedBox(width: 8),
            Text(
              LocaleKeys.watchCookingVideo.tr(),
              style: AppStyles.font30WhiteSemiBold.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
