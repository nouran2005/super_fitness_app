import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/auth/data/models/response/user_dto.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';

part 'signup_dto.g.dart';

@JsonSerializable()
class SignupDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserModelDto? user;

  SignupDto({this.message, this.token, this.user});

  SignupModel toSignupModel() {
    return SignupModel(
      id: user?.id,
      firstName: user?.firstName,
      lastName: user?.lastName,
      email: user?.email,
      gender: user?.gender,
      height: user?.height,
      weight: user?.weight,
    );
  }

  factory SignupDto.fromJson(Map<String, dynamic> json) =>
      _$SignupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignupDtoToJson(this);
}
