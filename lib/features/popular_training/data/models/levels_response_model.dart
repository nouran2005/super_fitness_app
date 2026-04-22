import 'package:json_annotation/json_annotation.dart';

part 'levels_response_model.g.dart';

@JsonSerializable()
class LevelsResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'levels')
  final List<LevelModel>? levels;

  const LevelsResponseModel({this.message, this.levels});

  factory LevelsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsResponseModelToJson(this);
}

@JsonSerializable()
class LevelModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  const LevelModel({this.id, this.name});

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
