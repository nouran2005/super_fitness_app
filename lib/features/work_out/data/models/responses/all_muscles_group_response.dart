import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscles_group.dart';

part 'all_muscles_group_response.g.dart';

@JsonSerializable()
class AllMusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroup>? musclesGroup;

  AllMusclesGroupResponse({this.message, this.musclesGroup});

  factory AllMusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$AllMusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesGroupResponseToJson(this);
  }
}
