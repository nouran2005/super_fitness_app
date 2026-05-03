import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/api/datasources/signin_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/signin/data/models/response/user.dart';

import 'signin_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late SigninRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = SigninRemoteDataSourceImpl(mockApiClient);
  });

  group("SigninRemoteDataSourceImpl.signin()", () {
    test('should return ApiSuccess when signin succeeds', () async {
      final fakeDto = SigninResponse(
        message: 'Success',
        token: 'fake_token',
        user: User(
          activityLevel: '',
          age: 20,
          email: 'test@gmail.com',
          firstName: 'test',
          gender: 'female',
          height: 160,
          weight: 60,
          goal: 'loose weight',
          id: '2',
          photo: '',
          lastName: 'test1',
        ),
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/auth/signin'),
          statusCode: 200,
        ),
      );
      when(mockApiClient.signIn(any)).thenAnswer((_) async => fakeResponse);

      final result =
          await dataSource.signin(
                SigninPostModel(email: 'test@gmailcom', password: 'Test@123'),
              )
              as SuccessApiResult<SigninResponse>;

      expect(result, isA<SuccessApiResult<SigninResponse>>());
      expect(result.data.token, fakeDto.token);
      expect(result.data.user!.email, fakeDto.user!.email);
      verify(mockApiClient.signIn(any)).called(1);
    });

    test('should return ApiFailure when Signin throws exception', () async {
      when(mockApiClient.signIn(any)).thenThrow(Exception('Network error'));

      final result =
          await dataSource.signin(
                SigninPostModel(email: 'test@gmailcom', password: 'Test@123'),
              )
              as ErrorApiResult<SigninResponse>;

      expect(result, isA<ErrorApiResult<SigninResponse>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.signIn(any)).called(1);
    });
  });
}
