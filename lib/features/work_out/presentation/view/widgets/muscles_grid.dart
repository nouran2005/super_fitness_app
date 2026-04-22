import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_card.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/app/core/widgets/empty_data_widget.dart';

class MusclesGrid extends StatelessWidget {
  const MusclesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkOutCubit, WorkOutStates>(
      builder: (context, state) {
        if (state.musclesByGroupResource.isLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
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
            return const EmptyDataWidget(
              message: 'No workouts found',
              icon: Icons.fitness_center_outlined,
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
              return MuscleCard(muscle: muscles[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
