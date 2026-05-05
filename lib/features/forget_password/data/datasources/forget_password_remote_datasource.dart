import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';

abstract interface class ForgetPasswordRemoteDataSource {
  Future<ApiResult<ForgotPasswordResponseModel>> forgetPassword(
    ForgetPasswordRequestModel requestModel,
  );
  Future<ApiResult<VerifyCodeResponseModel>> verifyOtp(
    VerifyCodeRequestModel requestModel,
  );
  Future<ApiResult<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestModel requestModel,
  );
}
