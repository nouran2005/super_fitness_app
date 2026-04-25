import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';

abstract interface class PopularTrainingRepo {
  Future<ApiResult<MusclesRandomEntity>> getRandomMuscles();

  Future<ApiResult<LevelsEntity>> getLevels();

  Future<ApiResult<ExercisesByMuscleDifficultyResponseEntity>>
  getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
