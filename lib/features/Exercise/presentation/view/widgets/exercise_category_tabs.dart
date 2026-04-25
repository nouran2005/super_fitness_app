import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class ExerciseCategoryTabs extends StatelessWidget {
  final List<ExerciseCategoryEntity> categories;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  const ExerciseCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(categories.length, (index) {
          final isSelected = selectedCategoryIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onCategorySelected(index),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  categories[index].name,
                  style: AppStyles.font14White.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.white60,
                    fontSize: size.width * 0.032,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
