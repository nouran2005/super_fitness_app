import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/data/datasources/popular_training_remote_datasource.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';

@LazySingleton(as: PopularTrainingRepo)
class PopularTrainingRepoImpl implements PopularTrainingRepo {
  final PopularTrainingRemoteDataSource _remoteDataSource;

  PopularTrainingRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<MusclesRandomEntity>> getRandomMuscles() async {
    final result = await _remoteDataSource.getRandomMuscles();

    switch (result) {
      case SuccessApiResult<MusclesRandomResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<MusclesRandomResponseModel>():
        return ErrorApiResult<MusclesRandomEntity>(error: result.error);
    }
  }

  @override
  Future<ApiResult<LevelsEntity>> getLevels() async {
    final result = await _remoteDataSource.getLevels();

    switch (result) {
      case SuccessApiResult<LevelsResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<LevelsResponseModel>():
        return ErrorApiResult<LevelsEntity>(error: result.error);
    }
  }

  @override
  Future<ApiResult<ExercisesByMuscleDifficultyResponseEntity>>
  getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    final result = await _remoteDataSource.getExercisesByMuscleDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );

    switch (result) {
      case SuccessApiResult<ExercisesByMuscleDifficultyResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>():
        return ErrorApiResult<ExercisesByMuscleDifficultyResponseEntity>(
          error: result.error,
        );
    }
  }
}
