import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';

class WorkOutBody extends StatelessWidget {
  const WorkOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(Assets.imagesHomeBackground),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Workouts',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            _buildGroupsList(),
            const SizedBox(height: 20),
            Expanded(child: _buildMusclesGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    return BlocBuilder<WorkOutCubit, WorkOutStates>(
      buildWhen: (previous, current) =>
          previous.musclesGroupResource != current.musclesGroupResource ||
          previous.selectedGroupId != current.selectedGroupId,
      builder: (context, state) {
        if (state.musclesGroupResource.isLoading) {
          return const SizedBox(
            height: 40,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        if (state.musclesGroupResource.isSuccess) {
          final groups = state.musclesGroupResource.data?.musclesGroup ?? [];
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groups.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final group = groups[index];
                final isSelected = state.selectedGroupId == group.id;
                return GestureDetector(
                  onTap: () {
                    context.read<WorkOutCubit>().doEvent(
                      GetMusclesByGroup(
                        language: context.locale.languageCode,
                        muscleGroupId: group.id ?? '',
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      group.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox(height: 40);
      },
    );
  }

  Widget _buildMusclesGrid() {
    return BlocBuilder<WorkOutCubit, WorkOutStates>(
      buildWhen: (previous, current) =>
          previous.musclesByGroupResource != current.musclesByGroupResource,
      builder: (context, state) {
        if (state.musclesByGroupResource.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state.musclesByGroupResource.isError) {
          return Center(
            child: Text(
              state.musclesByGroupResource.error ?? 'Error',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (state.musclesByGroupResource.isSuccess) {
          final muscles = state.musclesByGroupResource.data?.muscles ?? [];
          if (muscles.isEmpty) {
            return const Center(
              child: Text(
                'No workouts found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: muscles.length,
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(muscle.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    muscle.name ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
