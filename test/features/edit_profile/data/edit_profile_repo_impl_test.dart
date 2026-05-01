import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/repos/edit_profile_repo_impl.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSource])
void main() {
  late MockEditProfileRemoteDataSource mockRemoteDataSource;
  late EditProfileRepoImpl repository;

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSource();
    repository = EditProfileRepoImpl(mockRemoteDataSource);

    provideDummy<ApiResult<LoggedUserDataResponseModel>>(
      SuccessApiResult(
        data: LoggedUserDataResponseModel(message: '', user: null),
      ),
    );
    provideDummy<ApiResult<String>>(SuccessApiResult(data: ''));
  });

  group('getLoggedUserData', () {
    const tResponseModel = LoggedUserDataResponseModel(
      message: 'Success',
      user: null,
    );
    final tResponseEntity = tResponseModel.toEntity();

    test(
      'should return data when the call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.getLoggedUserData(),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repository.getLoggedUserData();

        verify(mockRemoteDataSource.getLoggedUserData());
        expect(result, isA<SuccessApiResult<LoggedUserDataResponseEntity>>());
        expect(
          (result as SuccessApiResult<LoggedUserDataResponseEntity>).data,
          equals(tResponseEntity),
        );
      },
    );

    test(
      'should return ErrorApiResult when the call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.getLoggedUserData(),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Server Failure'));

        final result = await repository.getLoggedUserData();

        verify(mockRemoteDataSource.getLoggedUserData());
        expect(result, isA<ErrorApiResult<LoggedUserDataResponseEntity>>());
        expect(
          (result as ErrorApiResult<LoggedUserDataResponseEntity>).error,
          equals('Server Failure'),
        );
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
    final tResponseEntity = tResponseModel.toEntity();

    test(
      'should return data when the call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.editProfile(tRequestModel),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repository.editProfile(tRequestModel);

        verify(mockRemoteDataSource.editProfile(tRequestModel));
        expect(result, isA<SuccessApiResult<LoggedUserDataResponseEntity>>());
        expect(
          (result as SuccessApiResult<LoggedUserDataResponseEntity>).data,
          equals(tResponseEntity),
        );
      },
    );

    test(
      'should return ErrorApiResult when the call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.editProfile(tRequestModel),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Server Failure'));

        final result = await repository.editProfile(tRequestModel);

        verify(mockRemoteDataSource.editProfile(tRequestModel));
        expect(result, isA<ErrorApiResult<LoggedUserDataResponseEntity>>());
        expect(
          (result as ErrorApiResult<LoggedUserDataResponseEntity>).error,
          equals('Server Failure'),
        );
      },
    );
  });

  group('uploadImage', () {
    final tFile = File('dummy.png');
    const tResponse = 'Image uploaded successfully';

    test(
      'should return String when the call to remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.uploadImage(tFile),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

        final result = await repository.uploadImage(tFile);

        verify(mockRemoteDataSource.uploadImage(tFile));
        expect(result, isA<SuccessApiResult<String>>());
        expect((result as SuccessApiResult<String>).data, equals(tResponse));
      },
    );

    test(
      'should return ErrorApiResult when the call to remote data source is unsuccessful',
      () async {
        when(
          mockRemoteDataSource.uploadImage(tFile),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Server Failure'));

        final result = await repository.uploadImage(tFile);

        verify(mockRemoteDataSource.uploadImage(tFile));
        expect(result, isA<ErrorApiResult<String>>());
        expect(
          (result as ErrorApiResult<String>).error,
          equals('Server Failure'),
        );
      },
    );
  });
}
