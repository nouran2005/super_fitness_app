import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/widgets/section_header.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/app_Par.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/categorySection.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/recommendation_item.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/recommendation_section.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_args.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_list.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_group_sections.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscles_horizontal_list.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/sections background.png',
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            // Content
            SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      CustomAppBar(
                        userName: 'Ahmed',
                        photoAsset: 'assets/images/prfofle photo .png',
                      ),
                      const SizedBox(height: 8),
                      const CategorySection(),
                      const SizedBox(height: 24),
                      RecommendationSection(
                        title: LocaleKeys.recommendationToDay.tr(),
                        showSeeAll: false,
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: LocaleKeys.upcomingWorkouts.tr(),
                        onSeeAllTap: () {
                          context.read<AppSectionsCubit>().changePage(2);
                        },
                      ),
                      const SizedBox(height: 12),
                      const MuscleGroupSections(),
                      const SizedBox(height: 16),
                      const MusclesHorizontalList(),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: LocaleKeys.recommendationForYou.tr(),
                        onSeeAllTap: () {
                          context.push(RouteNames.meals);
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<MealsCubit, MealsStates>(
                        builder: (context, state) {
                          final meal = state.mealsByCategoryResource.data?.meals
                              ?.whereType<MealsModel>()
                              .toList();
                          final category =
                              state.mealsCategoriesResource.data?.categories;

                          if (meal == null ||
                              category == null ||
                              meal.isEmpty ||
                              category.isEmpty) {
                            return const SizedBox();
                          }

                          return SizedBox(
                            height: 140,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final itemMeal = meal[index % meal.length];
                                final itemCategory =
                                    category[index % category.length];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 120,
                                    child: RecommendationItem(
                                      onTap: () {
                                        context.push(
                                          RouteNames.mealDeails,
                                          extra: MealDetailsArgs(
                                            mealId: itemMeal.idMeal!,
                                            meals: meal,
                                          ),
                                        );
                                      },
                                      isNetworkImage: true,
                                      imagePath: itemMeal.strMealThumb!,
                                      label: itemCategory!.strCategory!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      PopularTrainingList(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
