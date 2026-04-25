import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

abstract class ExerciseRepo {
  Future<ApiResult<ExerciseResponseEntity>> getExercises();
}
