import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/values/muscle_group_ids.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_entity.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/container_title.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class PopularTrainingItem extends StatelessWidget {
  final PopularTrainingEntity entity;

  const PopularTrainingItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;

    final cardWidth = screenWidth * 0.5;

    return GestureDetector(
      onTap: () {
        context.push(
          RouteNames.exercises,
          extra: {
            'muscleGroupId':
                MuscleGroupIds.getId(entity.exercise.muscleGroupId) ??
                '69d982ed85f6bfa972bf2218',
            'initialExerciseId': entity.exercise.id,
            'initialDifficultyLevel': entity.exercise.difficultyLevel,
          },
        );
      },
      child: SizedBox(
        width: screenWidth * 0.58,
        height: screenHeight * 0.22,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: entity.muscleImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.blackColor,
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: Colors.white70,
                      size: screenWidth * 0.30,
                    ),
                  ),
                ),
              ),
              Container(color: AppColors.blackColor.withValues(alpha: 0.67)),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entity.exercise.exercise,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: cardWidth * 0.09,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ContainerTitle(
                            text:
                                '${entity.totalExercises} ${LocaleKeys.Tasks.tr()}',
                            textStyle: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: cardWidth * 0.068,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),

                          ContainerTitle(
                            text: entity.exercise.difficultyLevel,
                            textStyle: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: AppColors.primary,
                                  fontSize: cardWidth * 0.068,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
