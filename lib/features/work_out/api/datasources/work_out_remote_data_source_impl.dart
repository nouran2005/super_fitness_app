import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/work_out/data/datasources/work_out_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';

@Injectable(as: WorkOutRemoteDataSourceContract)
class WorkOutRemoteDataSourceImpl extends WorkOutRemoteDataSourceContract {
  final ApiClient apiClient;

  WorkOutRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<AllMusclesGroupResponse>> getAllMusclesGroup({
    required String language,
  }) {
    return safeApiCall(
      call: () => apiClient.getAllMusclesGroup(language: language),
    );
  }

  @override
  Future<ApiResult<AllMusclesByMuscleGroupResponse>>
  getAllMusclesByMuscleGroup({
    required String language,
    required String muscleGroupId,
  }) {
    return safeApiCall(
      call: () => apiClient.getAllMusclesByMuscleGroup(
        language: language,
        muscleGroupId: muscleGroupId,
      ),
    );
  }
}
