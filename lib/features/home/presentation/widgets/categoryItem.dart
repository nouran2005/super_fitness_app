import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/upcoming_feature_dialog.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.name,
    this.onTap,
  });

  final String imagePath;
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (name == LocaleKeys.trainer) {
          onTap?.call();
        } else if (name == LocaleKeys.fitness) {
          context.push(RouteNames.exercises);
        } else {
          UpcomingFeatureDialog.show(context, name);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.14,
              height: screenWidth * 0.14,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            const SizedBox(height: 4),
            Text(
              name.tr(),
              style: AppStyles.baloo12Regular.copyWith(
                fontSize: screenWidth * 0.02,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
