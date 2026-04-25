import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class ExerciseStates {
  final Resource<ExerciseResponseEntity> exerciseResource;
  final Resource<List<ExerciseEntity>> beginnerResource;
  final Resource<List<ExerciseEntity>> intermediateResource;
  final Resource<List<ExerciseEntity>> advancedResource;

  ExerciseStates({
    required this.exerciseResource,
    required this.beginnerResource,
    required this.intermediateResource,
    required this.advancedResource,
  });

  ExerciseStates copyWith({
    Resource<ExerciseResponseEntity>? exerciseResource,
    Resource<List<ExerciseEntity>>? beginnerResource,
    Resource<List<ExerciseEntity>>? intermediateResource,
    Resource<List<ExerciseEntity>>? advancedResource,
  }) {
    return ExerciseStates(
      exerciseResource: exerciseResource ?? this.exerciseResource,
      beginnerResource: beginnerResource ?? this.beginnerResource,
      intermediateResource: intermediateResource ?? this.intermediateResource,
      advancedResource: advancedResource ?? this.advancedResource,
    );
  }
}
