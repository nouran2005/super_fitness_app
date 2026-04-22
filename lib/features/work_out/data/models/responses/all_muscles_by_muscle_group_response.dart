import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscle_group.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscles.dart';

part 'all_muscles_by_muscle_group_response.g.dart';

@JsonSerializable()
class AllMusclesByMuscleGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MuscleGroup? muscleGroup;
  @JsonKey(name: "muscles")
  final List<Muscles>? muscles;

  AllMusclesByMuscleGroupResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory AllMusclesByMuscleGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$AllMusclesByMuscleGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesByMuscleGroupResponseToJson(this);
  }
}
