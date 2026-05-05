import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
part 'reset_password_response_model.g.dart';

@JsonSerializable()
class ResetPasswordResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'token')
  final String token;
  ResetPasswordResponseModel({required this.message, required this.token});
  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordResponseModelToJson(this);
  ResetPasswordEntity toEntity() =>
      ResetPasswordEntity(message: message, token: token);
}
