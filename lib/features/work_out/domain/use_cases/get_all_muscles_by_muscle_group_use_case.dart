import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/repositories/work_out_repository.dart';

@injectable
class GetAllMusclesByMuscleGroupUseCase {
  final WorkOutRepository _repository;

  GetAllMusclesByMuscleGroupUseCase(this._repository);

  Future<ApiResult<AllMusclesByMuscleGroupResponseEntity>> execute({
    required String language,
    required String muscleGroupId,
  }) {
    return _repository.getAllMusclesByMuscleGroup(
      language: language,
      muscleGroupId: muscleGroupId,
    );
  }
}
