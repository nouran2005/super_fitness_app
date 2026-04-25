import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';

class PopularTrainingEntity {
  final ExerciseEntity exercise;
  final String muscleImage;
  final String muscleName;
  final int totalExercises;

  const PopularTrainingEntity({
    required this.exercise,
    required this.muscleImage,
    required this.muscleName,
    required this.totalExercises,
  });
}
