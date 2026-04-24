import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';

part 'muscles_random_response_model.g.dart';

@JsonSerializable()
class MusclesRandomResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'totalMuscles')
  final int? totalMuscles;

  @JsonKey(name: 'muscles')
  final List<RandomMuscleModel>? muscles;

  const MusclesRandomResponseModel({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory MusclesRandomResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MusclesRandomResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesRandomResponseModelToJson(this);

  MusclesRandomEntity toEntity() {
    return MusclesRandomEntity(
      muscles:
          muscles
              ?.where((e) => e.id != null && e.id!.isNotEmpty)
              .map(
                (e) => MuscleEntity(
                  id: e.id!,
                  name: e.name ?? '',
                  image: e.image ?? '',
                ),
              )
              .toList() ??
          [],
    );
  }
}

@JsonSerializable()
class RandomMuscleModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'image')
  final String? image;

  const RandomMuscleModel({this.id, this.name, this.image});

  factory RandomMuscleModel.fromJson(Map<String, dynamic> json) =>
      _$RandomMuscleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RandomMuscleModelToJson(this);
}
