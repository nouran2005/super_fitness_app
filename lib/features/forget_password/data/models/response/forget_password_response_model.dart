import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
part 'forget_password_response_model.g.dart';

@JsonSerializable()
class ForgotPasswordResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'info')
  final String info;
  ForgotPasswordResponseModel({required this.message, required this.info});
  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseModelToJson(this);

  ForgetPasswordEntity toEntity() =>
      ForgetPasswordEntity(message: message, info: info);
}
