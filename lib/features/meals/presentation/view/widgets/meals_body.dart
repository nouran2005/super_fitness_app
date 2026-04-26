import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/categories_tab_bar.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_list.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class MealsBody extends StatelessWidget {
  const MealsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        top: 40,
        bottom: 60,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Image.asset(Assets.imagesArrowBack),
              ),
              SizedBox(width: width * 0.12),
              Text(
                LocaleKeys.foodRecommendation.tr(),
                style: AppStyles.black24SemiBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          const CategoriesTabBar(),
          const MealsList(),
        ],
      ),
    );
  }
}
