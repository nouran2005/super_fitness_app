import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/api/datasources/auth_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/auth/data/models/response/user_dto.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = AuthRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group("AuthRemoteDataSourceImpl.signUp()", () {
    test('should return ApiSuccess when signup succeeds', () async {
      final fakeDto = SignupDto(
        message: 'Success',
        token: 'fake_token',
        user: UserModelDto(
          firstName: 'mariam',
          lastName: 'mohamed',
          email: 'mariam@gmailcom',
          gender: 'female',
          height: 163,
          weight: 66,
          role: 'loseWeight',
        ),
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/auth/signup'),
          statusCode: 200,
        ),
      );
      when(mockApiClient.signUp(any)).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.signUp(
                SignupRequest(
                  firstName: 'mariam',
                  lastName: 'mohamed',
                  email: 'mariam@gmailcom',
                  password: 'password123',
                  gender: 'female',
                  height: 163,
                  weight: 66,
                  goal: 'loseWeight',
                ),
              )
              as SuccessApiResult<SignupDto>;

      expect(result, isA<SuccessApiResult<SignupDto>>());
      expect(result.data.token, fakeDto.token);
      expect(result.data.user!.email, fakeDto.user!.email);
      verify(mockApiClient.signUp(any)).called(1);
    });

    test('should return ApiFailure when signup throws exception', () async {
      when(mockApiClient.signUp(any)).thenThrow(Exception('Network error'));

      final result =
          await dataSource.signUp(
                SignupRequest(
                  firstName: 'mariam',
                  lastName: 'mohamed',
                  email: 'mariam@gmailcom',
                  password: 'password123',
                  gender: 'female',
                  height: 163,
                  weight: 66,
                  goal: 'loseWeight',
                ),
              )
              as ErrorApiResult<SignupDto>;

      expect(result, isA<ErrorApiResult<SignupDto>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.signUp(any)).called(1);
    });
  });

  group("AuthRemoteDataSourceImpl.logout()", () {
    test('should return ApiSuccess when logout succeeds', () async {
      final fakeDto = LogoutResponse(message: 'Success', error: '');
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/auth/logout'),
          statusCode: 200,
        ),
      );
      when(
        mockApiClient.logout(token: 'token'),
      ).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.logout(token: 'token')
              as SuccessApiResult<LogoutResponse>;

      expect(result, isA<SuccessApiResult<LogoutResponse>>());
      expect(result.data.message, fakeDto.message);
      verify(mockApiClient.logout(token: 'token')).called(1);
    });

    test('should return ApiFailure when logout throws exception', () async {
      when(
        mockApiClient.logout(token: ''),
      ).thenThrow(Exception('Network error'));

      final result =
          await dataSource.logout(token: '') as ErrorApiResult<LogoutResponse>;

      expect(result, isA<ErrorApiResult<LogoutResponse>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.logout(token: '')).called(1);
    });
  });
}
