import 'package:json_annotation/json_annotation.dart';

part 'muscle_group.g.dart';

@JsonSerializable()
class MuscleGroup {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;

  MuscleGroup({this.Id, this.name});

  factory MuscleGroup.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupToJson(this);
  }
}
