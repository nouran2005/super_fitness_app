import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';

@injectable
class GetRandomMusclesUseCase {
  final PopularTrainingRepo _repo;

  GetRandomMusclesUseCase(this._repo);

  Future<ApiResult<MusclesRandomEntity>> getRandomMuscles() {
    return _repo.getRandomMuscles();
  }
}
