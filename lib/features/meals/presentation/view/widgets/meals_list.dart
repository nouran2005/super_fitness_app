import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_args.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_item.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/shimmer_grid_loading.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsCubit, MealsStates>(
      builder: (context, state) {
        final meals = state.mealsByCategoryResource.data;
        if (state.mealsByCategoryResource.status == Status.loading ||
            meals == null) {
          return Expanded(child: const ShimmerGridLoading());
        }
        if (meals.meals == null || meals.meals!.isEmpty) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Text(
                LocaleKeys.noMealsfound.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
            ],
          );
        }

        return Expanded(
          child: GridView.builder(
            itemCount: state.mealsByCategoryResource.data?.meals?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 0,
              childAspectRatio: 0.90,
            ),
            itemBuilder: (BuildContext context, int index) {
              final meal = meals.meals?[index];
              return MealItem(
                mealItem: meal!,
                onTap: () {
                  context.push(
                    RouteNames.mealDeails,
                    extra: MealDetailsArgs(
                      mealId: meal.idMeal!,
                      meals: (meals.meals ?? [])
                          .whereType<MealsModel>()
                          .toList(),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
