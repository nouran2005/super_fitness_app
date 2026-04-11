import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/signin/data/models/response/user.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';

part 'signin_response.g.dart';

@JsonSerializable()
class SigninResponse {
  String? message;
  User? user;
  String? token;

  SigninResponse({this.message, this.user, this.token});

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    return _$SigninResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);

  SigninEntity toSigninEntity() {
    return SigninEntity();
  }
}
