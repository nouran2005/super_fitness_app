import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_body.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';

class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key, required this.mealId});
  final int mealId;

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MealsCubit>();
    return Scaffold(
      body: BlocProvider<MealsCubit>(
        create: (context) => cubit,
        child: Stack(
          children: [
            AuthBlurryBackground(
              image: Assets.imagesHomeBackground,
              widget: MealDetailsBody(mealId: mealId),
            ),
          ],
        ),
      ),
    );
  }
}
