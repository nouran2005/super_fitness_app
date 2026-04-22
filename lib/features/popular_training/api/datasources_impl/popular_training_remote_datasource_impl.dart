import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/popular_training/data/datasources/popular_training_remote_datasource.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';

@LazySingleton(as: PopularTrainingRemoteDataSource)
class PopularTrainingRemoteDataSourceImpl
    implements PopularTrainingRemoteDataSource {
  final ApiClient _apiClient;

  PopularTrainingRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<MusclesRandomResponseModel>> getRandomMuscles() {
    return safeApiCall(call: () => _apiClient.getRandomMuscles());
  }

  @override
  Future<ApiResult<LevelsResponseModel>> getLevels() {
    return safeApiCall(call: () => _apiClient.getLevels());
  }

  @override
  Future<ApiResult<ExercisesByMuscleDifficultyResponseModel>>
  getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return safeApiCall(
      call: () => _apiClient.getExercisesByMuscleDifficulty(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
      ),
    );
  }
}
