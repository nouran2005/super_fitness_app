import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

class MealItem extends StatelessWidget {
  final MealsModel mealItem;
  final VoidCallback? onTap;
  const MealItem({super.key, required this.mealItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                mealItem.strMealThumb.toString(),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),

          Positioned(
            bottom: height * 0.035,
            left: width * 0.1,
            right: width * 0.1,
            child: Text(
              mealItem.strMeal.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.black16Medium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
