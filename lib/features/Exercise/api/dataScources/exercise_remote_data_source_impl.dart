import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/Exercise/data/dataScources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';

@Injectable(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ApiClient _apiClient;

  ExerciseRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ExerciseResponse>> getExercises() {
    return safeApiCall<ExerciseResponse>(
      call: () => _apiClient.getExercises(language: 'en'),
    );
  }
}
