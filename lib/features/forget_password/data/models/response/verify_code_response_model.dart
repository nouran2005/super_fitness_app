import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';
part 'verify_code_response_model.g.dart';

@JsonSerializable()
class VerifyCodeResponseModel {
  @JsonKey(name: 'status')
  final String status;
  VerifyCodeResponseModel({required this.status});
  factory VerifyCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyCodeResponseModelToJson(this);

  VerifyCodeEntity toEntity() => VerifyCodeEntity(status: status);
}
