import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_args.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_item.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/video_launch_widget.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class MealDetailsBody extends StatelessWidget {
  const MealDetailsBody({super.key, required this.mealId, required this.meals});
  final String mealId;
  final List<MealsModel> meals;

  List<MealsModel> getRelatedMeals() {
    final filtered = meals.where((m) => m.idMeal != mealId).toList();
    filtered.shuffle();
    return filtered.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    final relatedMeals = getRelatedMeals();
    final cubit = BlocProvider.of<MealsCubit>(context);
    return BlocBuilder<MealsCubit, MealsStates>(
      bloc: cubit..doIntent(GetMealDetailsIntent(mealId: mealId)),
      builder: (context, state) {
        if (state.mealDetailsResource.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state.mealDetailsResource.isError) {
          return Center(
            child: Text(
              state.mealDetailsResource.error ?? LocaleKeys.unknownError.tr(),
            ),
          );
        }
        final mealDetails = state.mealDetailsResource.data;
        final meal = mealDetails?.meals?[0];
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 344,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(meal!.strMealThumb.toString()),
                    onError: (_, _) => Icon(Icons.image_not_supported_sharp),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 40,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => context.pop(),
                        child: Image.asset(Assets.imagesArrowBack),
                      ),
                      Spacer(),
                      Text(
                        '${meal.strMeal}',
                        style: AppStyles.font30WhiteSemiBold.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      VideoLaunchWidget(
                        youtubeUrl: meal.strYoutube!,
                        thumbnail: meal.strMealThumb,
                      ),
                    ],
                  ),
                ),
              ),
              // if (meal?.strYoutube != null && meal!.strYoutube!.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: MealYoutubePlayer(youtubeUrl: meal.strYoutube!),
              //   ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  LocaleKeys.ingredients.tr(),
                  style: AppStyles.white13medium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MealsIngredientsList(mealModel: mealDetails),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  LocaleKeys.relatedMeals.tr(),
                  style: AppStyles.white13medium.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedMeals.length,
                  itemBuilder: (context, index) {
                    final item = relatedMeals[index];
                    return SizedBox(
                      width: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MealItem(
                          mealItem: item,
                          onTap: () {
                            context.push(
                              RouteNames.mealDeails,
                              extra: MealDetailsArgs(
                                mealId: item.idMeal.toString(),
                                meals: meals,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
