import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {
  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'weight')
  final int? weight;

  @JsonKey(name: 'goal')
  final String? goal;

  @JsonKey(name: 'activityLevel')
  final String? activityLevel;

  const EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.activityLevel,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
