import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';

@injectable
class GetLevelsUseCase {
  final PopularTrainingRepo _repo;

  GetLevelsUseCase(this._repo);

  Future<ApiResult<LevelsEntity>> getLevels() {
    return _repo.getLevels();
  }
}
