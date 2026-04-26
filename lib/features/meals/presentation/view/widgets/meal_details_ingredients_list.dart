import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class MealsIngredientsList extends StatelessWidget {
  const MealsIngredientsList({super.key, required this.mealModel});
  final MealDetailsModel? mealModel;

  @override
  Widget build(BuildContext context) {
    final meal = mealModel?.meals?.isNotEmpty == true
        ? mealModel!.meals!.first
        : null;

    if (meal == null) {
      return Center(
        child: Text(
          LocaleKeys.noIngredientsAvailable.tr(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final ingredients = [
      meal.strIngredient1,
      meal.strIngredient2,
      meal.strIngredient3,
      meal.strIngredient4,
      meal.strIngredient5,
      meal.strIngredient6,
      meal.strIngredient7,
      meal.strIngredient8,
      meal.strIngredient9,
      meal.strIngredient10,
      meal.strIngredient11,
      meal.strIngredient12,
      meal.strIngredient13,
      meal.strIngredient14,
      meal.strIngredient15,
      meal.strIngredient16,
      meal.strIngredient17,
      meal.strIngredient18,
      meal.strIngredient19,
      meal.strIngredient20,
    ].where((e) => e != null && e.isNotEmpty).toList();

    final measures = [
      meal.strMeasure1,
      meal.strMeasure2,
      meal.strMeasure3,
      meal.strMeasure4,
      meal.strMeasure5,
      meal.strMeasure6,
      meal.strMeasure7,
      meal.strMeasure8,
      meal.strMeasure9,
      meal.strMeasure10,
      meal.strMeasure11,
      meal.strMeasure12,
      meal.strMeasure13,
      meal.strMeasure14,
      meal.strMeasure15,
      meal.strMeasure16,
      meal.strMeasure17,
      meal.strMeasure18,
      meal.strMeasure19,
      meal.strMeasure20,
    ].where((e) => e != null && e.isNotEmpty).toList();

    return GlassBlurContainer(
      padding: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(20),
      borderColor: Colors.transparent,
      blurSigma: 20,
      backgroundColor: AppColors.grey.withOpacity(0.2),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColors.grey.withOpacity(0.4),
            thickness: 1,
            height: 1,
          );
        },
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            dense: true,
            title: Text(
              '${ingredients[index]}',
              style: AppStyles.black16Medium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              '${measures[index]}',
              style: AppStyles.grey14Regular.copyWith(
                color: AppColors.primary,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
