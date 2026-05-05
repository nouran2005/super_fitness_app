import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/repo/exercise_repo.dart';

@injectable
class GetExercisesUseCase {
  final ExerciseRepo _repository;

  GetExercisesUseCase(this._repository);

  Future<ApiResult<ExerciseResponseEntity>> execute() async {
    return await _repository.getExercises();
  }
}
