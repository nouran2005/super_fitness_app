import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';

abstract class WorkOutRemoteDataSourceContract {
  Future<ApiResult<AllMusclesGroupResponse>> getAllMusclesGroup({
    required String language,
  });

  Future<ApiResult<AllMusclesByMuscleGroupResponse>>
  getAllMusclesByMuscleGroup({
    required String language,
    required String muscleGroupId,
  });
}
