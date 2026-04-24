import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/data/datasources/work_out_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/repositories/work_out_repository.dart';

@Injectable(as: WorkOutRepository)
class WorkOutRepositoryImpl extends WorkOutRepository {
  final WorkOutRemoteDataSourceContract remoteDataSource;

  WorkOutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<AllMusclesGroupResponseEntity>> getAllMusclesGroup({
    required String language,
  }) async {
    final response = await remoteDataSource.getAllMusclesGroup(
      language: language,
    );
    switch (response) {
      case SuccessApiResult<AllMusclesGroupResponse>():
        return SuccessApiResult<AllMusclesGroupResponseEntity>(
          data: response.data.toEntity(),
        );
      case ErrorApiResult<AllMusclesGroupResponse>():
        return ErrorApiResult<AllMusclesGroupResponseEntity>(
          error: response.error.toString(),
        );
    }
  }

  @override
  Future<ApiResult<AllMusclesByMuscleGroupResponseEntity>>
  getAllMusclesByMuscleGroup({
    required String language,
    required String muscleGroupId,
  }) async {
    final response = await remoteDataSource.getAllMusclesByMuscleGroup(
      language: language,
      muscleGroupId: muscleGroupId,
    );
    switch (response) {
      case SuccessApiResult<AllMusclesByMuscleGroupResponse>():
        return SuccessApiResult<AllMusclesByMuscleGroupResponseEntity>(
          data: response.data.toEntity(),
        );
      case ErrorApiResult<AllMusclesByMuscleGroupResponse>():
        return ErrorApiResult<AllMusclesByMuscleGroupResponseEntity>(
          error: response.error.toString(),
        );
    }
  }
}
