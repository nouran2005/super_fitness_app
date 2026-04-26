import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';
import 'package:super_fitness_app/features/home/domain/repo/home_repo.dart';

@injectable
class GetRandomMusclesUseCase {
  final HomeRepo _repository;

  GetRandomMusclesUseCase(this._repository);

  Future<RecommendationEntity> execute() async {
    return await _repository.getRandomMuscles();
  }
}
