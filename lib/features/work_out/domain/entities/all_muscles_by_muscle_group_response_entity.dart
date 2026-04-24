import 'package:super_fitness_app/features/work_out/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_entity.dart';

class AllMusclesByMuscleGroupResponseEntity {
  final String? message;
  final MuscleGroupEntity? muscleGroup;
  final List<MuscleEntity>? muscles;

  AllMusclesByMuscleGroupResponseEntity({
    this.message,
    this.muscleGroup,
    this.muscles,
  });
}
