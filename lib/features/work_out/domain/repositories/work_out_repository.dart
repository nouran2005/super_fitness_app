import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';

abstract class WorkOutRepository {
  Future<ApiResult<AllMusclesGroupResponseEntity>> getAllMusclesGroup({
    required String language,
  });

  Future<ApiResult<AllMusclesByMuscleGroupResponseEntity>>
  getAllMusclesByMuscleGroup({
    required String language,
    required String muscleGroupId,
  });
}
