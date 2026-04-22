import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/categories_tab_bar.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';

class MealsBody extends StatelessWidget {
  const MealsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MealsCubit>(context);
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(Assets.imagesArrowBack),
              SizedBox(width: width * 0.12),
              Text(
                'Food Recommendation',
                style: AppStyles.black24SemiBold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          const CategoriesTabBar(),
        ],
      ),
    );
  }
}
