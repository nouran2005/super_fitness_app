import 'package:json_annotation/json_annotation.dart';

part 'signin_post_model.g.dart';

@JsonSerializable()
class SigninPostModel {
  final String email;
  final String password;

  SigninPostModel({required this.email, required this.password});

  factory SigninPostModel.fromJson(Map<String, dynamic> json) =>
      _$SigninPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$SigninPostModelToJson(this);
}
