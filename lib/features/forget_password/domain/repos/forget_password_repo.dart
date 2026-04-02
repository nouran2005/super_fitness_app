import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';

abstract interface class ForgetPasswordRepo {
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(String email);

  Future<ApiResult<VerifyCodeEntity>> verifyCode(String code);

  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestModel requestModel,
  );
}
