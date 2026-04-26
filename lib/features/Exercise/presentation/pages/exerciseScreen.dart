import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart'; 
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/eserciseBody.dart';

class ExerciseScreen extends StatelessWidget {
  final String muscleGroupId;
  final String? initialExerciseId;
  final String? initialDifficultyLevel;

  const ExerciseScreen({
    super.key,
    required this.muscleGroupId,
    this.initialExerciseId,
    this.initialDifficultyLevel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExerciseCubit>(),
      child: ExerciseBody(
        muscleGroupId: muscleGroupId,
        initialExerciseId: initialExerciseId,
        initialDifficultyLevel: initialDifficultyLevel,
      ),
    );
  }
}