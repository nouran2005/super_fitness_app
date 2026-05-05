import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/repo/exercise_repo.dart';

@injectable
class GetExercisesRandomUseCase {
  final ExerciseRepo _repository;

  GetExercisesRandomUseCase(this._repository);

  Future<ApiResult<ExerciseResponseEntity>> execute({
    required String muscleGroupId,
    required String difficultyId,
  }) async {
    return await _repository.getExercisesRandom(
      muscleGroupId: muscleGroupId,
      difficultyId: difficultyId,
    );
  }
}
