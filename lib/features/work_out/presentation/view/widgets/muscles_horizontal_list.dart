import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_card.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/app/core/widgets/empty_data_widget.dart';

class MusclesHorizontalList extends StatelessWidget {
  const MusclesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkOutCubit, WorkOutStates>(
      builder: (context, state) {
        if (state.musclesByGroupResource.isLoading) {
          return SizedBox(
            height: 120,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[700]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          );
        }
        if (state.musclesByGroupResource.isError) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                state.musclesByGroupResource.error ?? 'Error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        if (state.musclesByGroupResource.isSuccess) {
          final muscles = state.musclesByGroupResource.data?.muscles ?? [];
          if (muscles.isEmpty) {
            return const SizedBox.shrink();
          }
          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: muscles.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  child: MuscleCard(muscle: muscles[index], isSmall: true),
                );
              },
            ),
          );
        }
        return const SizedBox(height: 120);
      },
    );
  }
}
