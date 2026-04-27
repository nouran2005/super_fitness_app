import 'package:json_annotation/json_annotation.dart';

part 'profile_data_dto.g.dart';

@JsonSerializable()
class ProfileDataDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'user')
  final ProfileUserDto? user;
  @JsonKey(name: 'error')
  final String? error;

  ProfileDataDto({this.message, this.user, this.error});

  factory ProfileDataDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDataDtoToJson(this);
}

@JsonSerializable()
class ProfileUserDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'age')
  final int? age;
  @JsonKey(name: 'weight')
  final int? weight;
  @JsonKey(name: 'height')
  final int? height;
  @JsonKey(name: 'activityLevel')
  final String? activityLevel;
  @JsonKey(name: 'goal')
  final String? goal;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'resetCodeVerified')
  final bool? resetCodeVerified;

  ProfileUserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
    this.resetCodeVerified,
  });

  factory ProfileUserDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileUserDtoToJson(this);
}
