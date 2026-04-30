import 'package:json_annotation/json_annotation.dart';

part 'logged_user_data_response_model.g.dart';

@JsonSerializable()
class LoggedUserDataResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'user')
  final LoggedUserModel? user;

  const LoggedUserDataResponseModel({this.message, this.user});

  factory LoggedUserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoggedUserDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedUserDataResponseModelToJson(this);
}

@JsonSerializable()
class LoggedUserModel {
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

  @JsonKey(name: 'passwordChangedAt')
  final String? passwordChangedAt;

  @JsonKey(name: 'resetCodeVerified')
  final bool? resetCodeVerified;

  const LoggedUserModel({
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
    this.passwordChangedAt,
    this.resetCodeVerified,
  });

  factory LoggedUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoggedUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedUserModelToJson(this);
}
