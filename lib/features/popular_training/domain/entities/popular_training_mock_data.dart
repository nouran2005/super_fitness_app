import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_entity.dart';

final List<PopularTrainingEntity> popularTrainingMockData = List.generate(
  3,
  (index) => const PopularTrainingEntity(
    exercise: ExerciseEntity(
      id: 'dummy',
      exercise: 'Skeletonizer Exercise Name',
      difficultyLevel: 'Beginner',
      shortYoutubeDemonstration: '',
    ),
    muscleImage: 'http://dummyimage.com/100x100/000/fff',
    muscleName: 'Muscle',
    totalExercises: 5,
  ),
);
