import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/api/datasources_impl/edit_profile_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';

import 'edit_profile_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late EditProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = EditProfileRemoteDataSourceImpl(mockApiClient);
  });

  Response<T> fakeResponse<T>(T data) => Response<T>(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  group('getLoggedUserData', () {
    const tResponseModel = LoggedUserDataResponseModel(
      message: 'Success',
      user: null,
    );

    test(
      'should return LoggedUserDataResponseModel when API call is successful',
      () async {
        when(mockApiClient.getLoggedUserData()).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.getLoggedUserData();

        verify(mockApiClient.getLoggedUserData());
        expect(result, isA<SuccessApiResult<LoggedUserDataResponseModel>>());
        expect(
          (result as SuccessApiResult<LoggedUserDataResponseModel>).data,
          equals(tResponseModel),
        );
      },
    );

    test(
      'should return ApiResult with failure when API call throws an error',
      () async {
        when(
          mockApiClient.getLoggedUserData(),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final result = await dataSource.getLoggedUserData();

        verify(mockApiClient.getLoggedUserData());
        expect(result, isA<ErrorApiResult<LoggedUserDataResponseModel>>());
      },
    );
  });

  group('editProfile', () {
    const tRequestModel = EditProfileRequestModel(
      firstName: 'John',
      lastName: 'Doe',
    );
    const tResponseModel = LoggedUserDataResponseModel(
      message: 'Profile updated',
      user: null,
    );

    test(
      'should return LoggedUserDataResponseModel when API call is successful',
      () async {
        when(mockApiClient.editProfile(tRequestModel)).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.editProfile(tRequestModel);

        verify(mockApiClient.editProfile(tRequestModel));
        expect(result, isA<SuccessApiResult<LoggedUserDataResponseModel>>());
        expect(
          (result as SuccessApiResult<LoggedUserDataResponseModel>).data,
          equals(tResponseModel),
        );
      },
    );

    test(
      'should return ApiResult with failure when API call throws an error',
      () async {
        when(
          mockApiClient.editProfile(tRequestModel),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));
        final result = await dataSource.editProfile(tRequestModel);

        verify(mockApiClient.editProfile(tRequestModel));
        expect(result, isA<ErrorApiResult<LoggedUserDataResponseModel>>());
      },
    );
  });

  group('uploadImage', () {
    final tFile = File('dummy.png');
    const tResponse = 'Image uploaded successfully';

    test('should return String when API call is successful', () async {
      when(mockApiClient.uploadImage(tFile)).thenAnswer(
        (_) async => HttpResponse(tResponse, fakeResponse(tResponse)),
      );
      final result = await dataSource.uploadImage(tFile);
      verify(mockApiClient.uploadImage(tFile));
      expect(result, isA<SuccessApiResult<String>>());
      expect((result as SuccessApiResult<String>).data, equals(tResponse));
    });

    test(
      'should return ApiResult with failure when API call throws an error',
      () async {
        when(
          mockApiClient.uploadImage(tFile),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));
        final result = await dataSource.uploadImage(tFile);
        verify(mockApiClient.uploadImage(tFile));
        expect(result, isA<ErrorApiResult<String>>());
      },
    );
  });
}
