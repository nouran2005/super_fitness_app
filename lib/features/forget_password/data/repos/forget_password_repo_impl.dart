import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/values/user_error_mesagges.dart';
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
    if (result is SuccessApiResult<ForgotPasswordResponseModel>) {
      return SuccessApiResult(data: result.data.toEntity());
    }

    if (result is ErrorApiResult<ForgotPasswordResponseModel>) {
      return ErrorApiResult<ForgetPasswordEntity>(error: result.error);
    }

    return ErrorApiResult<ForgetPasswordEntity>(
      error: UserErrorMessages.unknownError,
    );
  }

  @override
  Future<ApiResult<VerifyCodeEntity>> verifyCode(String code) async {
    final result = await _remoteDataSource.verifyOtp(
      VerifyCodeRequestModel(resetCode: code),
    );
    if (result is SuccessApiResult<VerifyCodeResponseModel>) {
      return SuccessApiResult(data: result.data.toEntity());
    }

    if (result is ErrorApiResult<VerifyCodeResponseModel>) {
      return ErrorApiResult<VerifyCodeEntity>(error: result.error);
    }

    return ErrorApiResult<VerifyCodeEntity>(
      error: UserErrorMessages.unknownError,
    );
  }

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestModel requestModel,
  ) async {
    final result = await _remoteDataSource.resetPassword(requestModel);
    if (result is SuccessApiResult<ResetPasswordResponseModel>) {
      return SuccessApiResult(data: result.data.toEntity());
    }

    if (result is ErrorApiResult<ResetPasswordResponseModel>) {
      return ErrorApiResult<ResetPasswordEntity>(error: result.error);
    }

    return ErrorApiResult<ResetPasswordEntity>(
      error: UserErrorMessages.unknownError,
    );
  }
}
