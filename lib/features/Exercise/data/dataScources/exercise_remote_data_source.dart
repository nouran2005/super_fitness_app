import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';

abstract class ExerciseRemoteDataSource {
  Future<ApiResult<ExerciseResponse>> getExercises();
  Future<ApiResult<ExerciseResponse>> getExercisesRandom({
    required String muscleGroupId,
    required String difficultyId,
  });
}
