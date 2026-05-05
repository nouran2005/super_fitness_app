import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_sections_bottom_nav_bar.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_body.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MealsCubit>();
    return Scaffold(
      extendBody: true,
      body: BlocProvider<MealsCubit>(
        create: (context) =>
            cubit
              ..doIntent(GetMealsCategoriesIntent(initialIndex: initialIndex)),
        child: Stack(
          children: [
            AuthBlurryBackground(
              blurSigmaX: 1,
              blurSigmaY: 1,
              blurAlpha: 50,
              image: Assets.imagesHomeBackground,
              widget: const MealsBody(),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppSectionsBottomNavBar(
                destinations: appSectionDestinations,
                currentIndex: null,
                onDestinationSelected: (index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
