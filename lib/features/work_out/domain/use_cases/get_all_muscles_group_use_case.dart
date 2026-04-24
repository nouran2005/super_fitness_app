import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/repositories/work_out_repository.dart';

@injectable
class GetAllMusclesGroupUseCase {
  final WorkOutRepository _repository;

  GetAllMusclesGroupUseCase(this._repository);

  Future<ApiResult<AllMusclesGroupResponseEntity>> execute({
    required String language,
  }) {
    return _repository.getAllMusclesGroup(language: language);
  }
}
