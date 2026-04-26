import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';

part 'recommendation_to _day.g.dart';

@JsonSerializable(explicitToJson: true)
class RecommendationToDay {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "totalMuscles")
  int? totalMuscles;
  @JsonKey(name: "muscles")
  List<Muscle>? muscles;

  RecommendationToDay({this.message, this.totalMuscles, this.muscles});

  factory RecommendationToDay.fromJson(Map<String, dynamic> json) =>
      _$RecommendationToDayFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationToDayToJson(this);

  RecommendationEntity toEntity() => RecommendationEntity(
    message: message,
    totalMuscles: totalMuscles,
    muscles: muscles?.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable()
class Muscle {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;

  Muscle({this.id, this.name, this.image});

  factory Muscle.fromJson(Map<String, dynamic> json) => _$MuscleFromJson(json);

  Map<String, dynamic> toJson() => _$MuscleToJson(this);

  MuscleEntity toEntity() => MuscleEntity(id: id, name: name, image: image);
}
