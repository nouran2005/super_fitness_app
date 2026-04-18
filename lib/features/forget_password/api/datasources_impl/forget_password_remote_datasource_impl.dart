import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/forget_password/data/datasources/forget_password_remote_datasource.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';

@LazySingleton(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  final ApiClient _apiClient;
  ForgetPasswordRemoteDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<ForgotPasswordResponseModel>> forgetPassword(
    ForgetPasswordRequestModel requestModel,
  ) {
    return safeApiCall(call: () => _apiClient.forgotPassword(requestModel));
  }

  @override
  Future<ApiResult<VerifyCodeResponseModel>> verifyOtp(
    VerifyCodeRequestModel requestModel,
  ) {
    return safeApiCall(call: () => _apiClient.verifyOtp(requestModel));
  }

  @override
  Future<ApiResult<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestModel requestModel,
  ) {
    return safeApiCall(call: () => _apiClient.resetPassword(requestModel));
  }
}
