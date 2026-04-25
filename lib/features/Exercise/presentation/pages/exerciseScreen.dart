import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/eserciseBody.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExerciseCubit>(),
      child: const ExerciseBody(),
    );
  }
}