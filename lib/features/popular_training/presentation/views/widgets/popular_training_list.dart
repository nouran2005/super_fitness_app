import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_events.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_item.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_mock_data.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class PopularTrainingList extends StatelessWidget {
  const PopularTrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;

    return BlocProvider(
      create: (context) =>
          getIt<PopularTrainingCubit>()
            ..onEvent(LoadPopularTrainingExercisesEvent()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              LocaleKeys.PopularsTraining.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<PopularTrainingCubit, PopularTrainingState>(
            builder: (context, state) {
              final resource = state.popularExercises;
              final isLoading = resource.isLoading || resource.isInitial;

              if (!isLoading && resource.isError) {
                return SizedBox(
                  height: screenHeight * 0.22,
                  child: Center(
                    child: Text(
                      resource.error ?? LocaleKeys.something_went_wrong.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final exercises = isLoading
                  ? popularTrainingMockData
                  : (resource.data ?? []);

              return Skeletonizer(
                enabled: isLoading,
                effect: ShimmerEffect(
                  baseColor: AppColors.grey.withValues(alpha: 0.5),
                  highlightColor: AppColors.grey.withValues(alpha: 0.1),
                ),
                child: SizedBox(
                  height: screenHeight * 0.22,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    itemCount: exercises.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 16),
                    itemBuilder: (context, index) =>
                        PopularTrainingItem(entity: exercises[index]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
