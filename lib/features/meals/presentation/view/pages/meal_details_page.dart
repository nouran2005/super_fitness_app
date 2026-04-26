import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_args.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_item.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MealDetailsPage extends StatefulWidget {
  const MealDetailsPage({super.key, required this.mealId, required this.meals});
  final String mealId;
  final List<MealsModel> meals;
  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  YoutubePlayerController? _controller;
  final cubit = getIt<MealsCubit>();

  List<MealsModel> getRelatedMeals() {
    final filtered = widget.meals
        .where((m) => m.idMeal != widget.mealId)
        .toList();
    filtered.shuffle();
    return filtered.take(6).toList();
  }

  @override
  void initState() {
    super.initState();
    cubit.doIntent(GetMealDetailsIntent(mealId: widget.mealId));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final relatedMeals = getRelatedMeals();

    return BlocProvider<MealsCubit>(
      create: (context) => cubit,
      child: BlocBuilder<MealsCubit, MealsStates>(
        builder: (context, state) {
          final mealDetails = state.mealDetailsResource.data;
          final meal = mealDetails?.meals?[0];

          final videoId = YoutubePlayer.convertUrlToId(meal?.strYoutube ?? '');
          if (videoId != null) {
            _controller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
                enableCaption: true,
                isLive: false,
                disableDragSeek: false,
              ),
            );
          }

          if (_controller == null) {
            return const SizedBox.shrink();
          }
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

          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.primary,
            ),
            builder: (context, player) {
              return Scaffold(
                body: AuthBlurryBackground(
                  image: Assets.imagesHomeBackground,
                  widget: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                meal!.strMealThumb.toString(),
                              ),
                              onError: (_, _) =>
                                  Icon(Icons.image_not_supported_sharp),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // video
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            LocaleKeys.watchCookingVideo.tr(),
                            style: AppStyles.white13medium.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: player,
                        ),
                        SizedBox(height: 16),

                        // ingredients
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

                        // related meals
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: MealItem(
                                    mealItem: item,
                                    onTap: () {
                                      context.push(
                                        RouteNames.mealDeails,
                                        extra: MealDetailsArgs(
                                          mealId: item.idMeal.toString(),
                                          meals: widget.meals,
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
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
