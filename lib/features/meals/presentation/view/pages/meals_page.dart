import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_body.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MealsCubit>();
    return Scaffold(
      body: BlocProvider<MealsCubit>(
        create: (context) => cubit..doIntent(GetMealsCategoriesIntent()),
        child: Stack(
          children: [
            AuthBlurryBackground(
              blurSigmaX: 1,
              blurSigmaY: 1,
              blurAlpha: 50,
              image: Assets.imagesHomeBackground,
              widget: const MealsBody(),
            ),
          ],
        ),
      ),
    );
  }
}
