import 'package:json_annotation/json_annotation.dart';

part 'changepassRequest.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  ChangePasswordRequest({this.password, this.newPassword});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
