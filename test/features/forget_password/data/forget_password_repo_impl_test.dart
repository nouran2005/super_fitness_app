import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/datasources/forget_password_remote_datasource.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/repos/forget_password_repo_impl.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  late MockForgetPasswordRemoteDataSource mockDataSource;
  late ForgetPasswordRepoImpl repo;

  setUp(() {
    mockDataSource = MockForgetPasswordRemoteDataSource();
    repo = ForgetPasswordRepoImpl(mockDataSource);

    provideDummy<ApiResult<ForgotPasswordResponseModel>>(
      SuccessApiResult(
        data: ForgotPasswordResponseModel(message: '', info: ''),
      ),
    );
    provideDummy<ApiResult<VerifyCodeResponseModel>>(
      SuccessApiResult(data: VerifyCodeResponseModel(status: '')),
    );
    provideDummy<ApiResult<ResetPasswordResponseModel>>(
      SuccessApiResult(
        data: ResetPasswordResponseModel(message: '', token: ''),
      ),
    );
  });

  group('forgetPassword', () {
    const tEmail = 'test@example.com';
    final tResponseModel = ForgotPasswordResponseModel(
      message: 'Reset email sent',
      info: 'Check your inbox',
    );
    final tEntity = ForgetPasswordEntity(
      message: 'Reset email sent',
      info: 'Check your inbox',
    );
    const tErrorMessage = 'Something went wrong';

    test(
      'should return SuccessApiResult with a ForgetPasswordEntity on success',
      () async {
        when(
          mockDataSource.forgetPassword(any),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.forgetPassword(tEmail);

        expect(result, isA<SuccessApiResult<ForgetPasswordEntity>>());
        final success = result as SuccessApiResult<ForgetPasswordEntity>;
        expect(success.data.message, tEntity.message);
        expect(success.data.info, tEntity.info);
        verify(mockDataSource.forgetPassword(any)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(mockDataSource.forgetPassword(any)).thenAnswer(
          (_) async =>
              ErrorApiResult<ForgotPasswordResponseModel>(error: tErrorMessage),
        );

        final result = await repo.forgetPassword(tEmail);

        expect(result, isA<ErrorApiResult<ForgetPasswordEntity>>());
        expect(
          (result as ErrorApiResult<ForgetPasswordEntity>).error,
          tErrorMessage,
        );
      },
    );
  });

  group('verifyCode', () {
    const tCode = '123456';
    final tResponseModel = VerifyCodeResponseModel(status: 'Success');
    final tEntity = VerifyCodeEntity(status: 'Success');
    const tErrorMessage = 'Invalid OTP code';

    test(
      'should return SuccessApiResult with a VerifyCodeEntity on success',
      () async {
        when(
          mockDataSource.verifyOtp(any),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.verifyCode(tCode);

        expect(result, isA<SuccessApiResult<VerifyCodeEntity>>());
        expect(
          (result as SuccessApiResult<VerifyCodeEntity>).data.status,
          tEntity.status,
        );
        verify(mockDataSource.verifyOtp(any)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(mockDataSource.verifyOtp(any)).thenAnswer(
          (_) async =>
              ErrorApiResult<VerifyCodeResponseModel>(error: tErrorMessage),
        );

        final result = await repo.verifyCode(tCode);

        expect(result, isA<ErrorApiResult<VerifyCodeEntity>>());
        expect(
          (result as ErrorApiResult<VerifyCodeEntity>).error,
          tErrorMessage,
        );
      },
    );
  });

  group('resetPassword', () {
    final tRequest = ResetPasswordRequestModel(
      email: 'test@example.com',
      newPassword: 'NewPass123',
    );
    final tResponseModel = ResetPasswordResponseModel(
      message: 'Password reset successfully',
      token: 'new_token_abc',
    );
    final tEntity = ResetPasswordEntity(
      message: 'Password reset successfully',
      token: 'new_token_abc',
    );
    const tErrorMessage = 'Reset failed';

    test(
      'should return SuccessApiResult with a ResetPasswordEntity on success',
      () async {
        when(
          mockDataSource.resetPassword(any),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.resetPassword(tRequest);

        expect(result, isA<SuccessApiResult<ResetPasswordEntity>>());
        final success = result as SuccessApiResult<ResetPasswordEntity>;
        expect(success.data.message, tEntity.message);
        expect(success.data.token, tEntity.token);
        verify(mockDataSource.resetPassword(any)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(mockDataSource.resetPassword(any)).thenAnswer(
          (_) async =>
              ErrorApiResult<ResetPasswordResponseModel>(error: tErrorMessage),
        );

        final result = await repo.resetPassword(tRequest);

        expect(result, isA<ErrorApiResult<ResetPasswordEntity>>());
        expect(
          (result as ErrorApiResult<ResetPasswordEntity>).error,
          tErrorMessage,
        );
      },
    );
  });
}
