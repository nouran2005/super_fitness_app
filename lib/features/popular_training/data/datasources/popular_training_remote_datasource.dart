import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';

abstract interface class PopularTrainingRemoteDataSource {
  Future<ApiResult<MusclesRandomResponseModel>> getRandomMuscles();

  Future<ApiResult<LevelsResponseModel>> getLevels();

  Future<ApiResult<ExercisesByMuscleDifficultyResponseModel>>
  getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
