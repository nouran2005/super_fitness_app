import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/categoryItem.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class _CategoryData {
  const _CategoryData({required this.imagePath, required this.name});
  final String imagePath;
  final String name;
}

const List<_CategoryData> _categories = [
  _CategoryData(imagePath: 'assets/images/Gym.png', name: LocaleKeys.gym),
  _CategoryData(
    imagePath: 'assets/images/fitness.png',
    name: LocaleKeys.fitness,
  ),
  _CategoryData(imagePath: 'assets/images/yoga.png', name: LocaleKeys.yoga),
  _CategoryData(
    imagePath: 'assets/images/Aerobics.png',
    name: LocaleKeys.aerobics,
  ),
  _CategoryData(
    imagePath: 'assets/images/Trainer.png',
    name: LocaleKeys.trainer,
  ),
];

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            LocaleKeys.category.tr(),
            style: TextStyle(
              fontSize: screenWidth * 0.025,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_categories.length * 2 - 1, (index) {
                  if (index.isEven) {
                    final catIndex = index ~/ 2;
                    final cat = _categories[catIndex];
                    return Expanded(
                      child: CategoryItem(
                        imagePath: cat.imagePath,
                        name: cat.name,
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        width: 1,
                        height: screenWidth * 0.12,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
