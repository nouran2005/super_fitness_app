import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/datasources/forget_password_remote_datasource.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/repos/forget_password_repo.dart';

@LazySingleton(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ForgetPasswordRemoteDataSource _remoteDataSource;

  ForgetPasswordRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ForgetPasswordEntity>> forgetPassword(String email) async {
    final result = await _remoteDataSource.forgetPassword(
      ForgetPasswordRequestModel(email: email),
    );

    switch (result) {
      case SuccessApiResult<ForgotPasswordResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<ForgotPasswordResponseModel>():
        return ErrorApiResult<ForgetPasswordEntity>(error: result.error);
    }
  }

  @override
  Future<ApiResult<VerifyCodeEntity>> verifyCode(String code) async {
    final result = await _remoteDataSource.verifyOtp(
      VerifyCodeRequestModel(resetCode: code),
    );

    switch (result) {
      case SuccessApiResult<VerifyCodeResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<VerifyCodeResponseModel>():
        return ErrorApiResult<VerifyCodeEntity>(error: result.error);
    }
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestModel requestModel,
  ) async {
    final result = await _remoteDataSource.resetPassword(requestModel);

    switch (result) {
      case SuccessApiResult<ResetPasswordResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<ResetPasswordResponseModel>():
        return ErrorApiResult<ResetPasswordEntity>(error: result.error);
    }
  }
}
