import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/data/dataScources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/repo/exercise_repo.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ExerciseResponseEntity>> getExercises() async {
    final result = await _remoteDataSource.getExercises();
    switch (result) {
      case SuccessApiResult<ExerciseResponse>():
        return SuccessApiResult<ExerciseResponseEntity>(
          data: result.data.toEntity(),
        );
      case ErrorApiResult<ExerciseResponse>():
        return ErrorApiResult<ExerciseResponseEntity>(error: result.error);
    }
  }

  @override
  Future<ApiResult<ExerciseResponseEntity>> getExercisesRandom({
    required String muscleGroupId,
    required String difficultyId,
  }) async {
    final result = await _remoteDataSource.getExercisesRandom(
      muscleGroupId: muscleGroupId,
      difficultyId: difficultyId,
    );
    switch (result) {
      case SuccessApiResult<ExerciseResponse>():
        return SuccessApiResult<ExerciseResponseEntity>(
          data: result.data.toEntity(),
        );
      case ErrorApiResult<ExerciseResponse>():
        return ErrorApiResult<ExerciseResponseEntity>(error: result.error);
    }
  }
}
