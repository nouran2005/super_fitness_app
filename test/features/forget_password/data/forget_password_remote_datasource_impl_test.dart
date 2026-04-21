import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/api/datasources_impl/forget_password_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';

import 'forget_password_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late ForgetPasswordRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ForgetPasswordRemoteDataSourceImpl(mockApiClient);
  });

  Response<T> fakeResponse<T>(T data) => Response<T>(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  group('forgetPassword', () {
    final tRequest = ForgetPasswordRequestModel(email: 'test@example.com');
    final tResponseModel = ForgotPasswordResponseModel(
      message: 'Reset email sent',
      info: 'Check your inbox',
    );

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(mockApiClient.forgotPassword(tRequest)).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );
        final result = await dataSource.forgetPassword(tRequest);

        expect(result, isA<SuccessApiResult<ForgotPasswordResponseModel>>());
        expect(
          (result as SuccessApiResult<ForgotPasswordResponseModel>).data,
          tResponseModel,
        );
        verify(mockApiClient.forgotPassword(tRequest)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(mockApiClient.forgotPassword(tRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'No internet connection',
          ),
        );

        final result = await dataSource.forgetPassword(tRequest);

        expect(result, isA<ErrorApiResult<ForgotPasswordResponseModel>>());
        expect(
          (result as ErrorApiResult<ForgotPasswordResponseModel>).error,
          'No internet connection',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<ForgotPasswordResponseModel>(
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.forgotPassword(tRequest),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.forgetPassword(tRequest);

        expect(result, isA<ErrorApiResult<ForgotPasswordResponseModel>>());
        expect(
          (result as ErrorApiResult<ForgotPasswordResponseModel>).error,
          'Failed with status code: 400',
        );
      },
    );
  });

  group('verifyOtp', () {
    final tRequest = VerifyCodeRequestModel(resetCode: '123456');
    final tResponseModel = VerifyCodeResponseModel(status: 'Success');

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(mockApiClient.verifyOtp(tRequest)).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.verifyOtp(tRequest);

        expect(result, isA<SuccessApiResult<VerifyCodeResponseModel>>());
        expect(
          (result as SuccessApiResult<VerifyCodeResponseModel>).data,
          tResponseModel,
        );
        verify(mockApiClient.verifyOtp(tRequest)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(mockApiClient.verifyOtp(tRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Connection timeout',
          ),
        );

        final result = await dataSource.verifyOtp(tRequest);

        expect(result, isA<ErrorApiResult<VerifyCodeResponseModel>>());
        expect(
          (result as ErrorApiResult<VerifyCodeResponseModel>).error,
          'Connection timeout',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<VerifyCodeResponseModel>(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.verifyOtp(tRequest),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.verifyOtp(tRequest);

        expect(result, isA<ErrorApiResult<VerifyCodeResponseModel>>());
        expect(
          (result as ErrorApiResult<VerifyCodeResponseModel>).error,
          'Failed with status code: 404',
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

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(mockApiClient.resetPassword(tRequest)).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.resetPassword(tRequest);

        expect(result, isA<SuccessApiResult<ResetPasswordResponseModel>>());
        expect(
          (result as SuccessApiResult<ResetPasswordResponseModel>).data,
          tResponseModel,
        );
        verify(mockApiClient.resetPassword(tRequest)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(mockApiClient.resetPassword(tRequest)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Server unavailable',
          ),
        );

        final result = await dataSource.resetPassword(tRequest);

        expect(result, isA<ErrorApiResult<ResetPasswordResponseModel>>());
        expect(
          (result as ErrorApiResult<ResetPasswordResponseModel>).error,
          'Server unavailable',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<ResetPasswordResponseModel>(
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.resetPassword(tRequest),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.resetPassword(tRequest);

        expect(result, isA<ErrorApiResult<ResetPasswordResponseModel>>());
        expect(
          (result as ErrorApiResult<ResetPasswordResponseModel>).error,
          'Failed with status code: 500',
        );
      },
    );
  });
}
