import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserModelDto {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "weight")
  final int? weight;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "_id")
  final String? id;

  UserModelDto({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.height,
    this.weight,
    this.role,
    this.id,
  });

  factory UserModelDto.fromJson(Map<String, dynamic> json) =>
      _$UserModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelDtoToJson(this);
}
