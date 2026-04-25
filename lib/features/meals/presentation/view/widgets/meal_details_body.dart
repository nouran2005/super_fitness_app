import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/video_launch_widget.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class MealDetailsBody extends StatelessWidget {
  const MealDetailsBody({super.key, required this.mealId});
  final int mealId;

  @override
  Widget build(BuildContext context) {
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
        return Column(
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
                    VideoLaunchWidget(meal: meal.strYoutube!),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MealsIngredientsList(mealModel: mealDetails),
              ),
            ),
          ],
        );
      },
    );
  }
}
