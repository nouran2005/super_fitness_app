import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';

class WorkOutStates {
  final Resource<AllMusclesGroupResponseEntity> musclesGroupResource;
  final Resource<AllMusclesByMuscleGroupResponseEntity> musclesByGroupResource;
  final String? selectedGroupId;

  WorkOutStates({
    Resource<AllMusclesGroupResponseEntity>? musclesGroupResource,
    Resource<AllMusclesByMuscleGroupResponseEntity>? musclesByGroupResource,
    this.selectedGroupId,
  }) : musclesGroupResource = musclesGroupResource ?? Resource.initial(),
       musclesByGroupResource = musclesByGroupResource ?? Resource.initial();

  WorkOutStates copyWith({
    Resource<AllMusclesGroupResponseEntity>? musclesGroupResource,
    Resource<AllMusclesByMuscleGroupResponseEntity>? musclesByGroupResource,
    String? selectedGroupId,
  }) {
    return WorkOutStates(
      musclesGroupResource: musclesGroupResource ?? this.musclesGroupResource,
      musclesByGroupResource:
          musclesByGroupResource ?? this.musclesByGroupResource,
      selectedGroupId: selectedGroupId ?? this.selectedGroupId,
    );
  }
}
