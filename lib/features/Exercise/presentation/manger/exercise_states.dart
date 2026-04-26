import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class ExerciseStates {
  final Resource<ExerciseResponseEntity> exerciseResource;
  final Resource<List<ExerciseEntity>> currentExercisesResource;

  ExerciseStates({
    required this.exerciseResource,
    required this.currentExercisesResource,
  });

  ExerciseStates copyWith({
    Resource<ExerciseResponseEntity>? exerciseResource,
    Resource<List<ExerciseEntity>>? currentExercisesResource,
  }) {
    return ExerciseStates(
      exerciseResource: exerciseResource ?? this.exerciseResource,
      currentExercisesResource: currentExercisesResource ?? this.currentExercisesResource,
    );
  }
}
