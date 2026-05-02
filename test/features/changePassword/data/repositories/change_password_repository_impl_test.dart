import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/datasources/change_password_remote_datasource.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/changePassword/data/repositories/change_password_repository_impl.dart';

import 'change_password_repository_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordRemoteDataSource])
void main() {
  provideDummy<ApiResult<ChangePasswordResponse>>(
    SuccessApiResult(data: ChangePasswordResponse()),
  );
  late ChangePasswordRepositoryImpl repository;

  late MockChangePasswordRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockChangePasswordRemoteDataSource();
    repository = ChangePasswordRepositoryImpl(mockRemoteDataSource);
  });

  group('ChangePasswordRepositoryImpl Tests', () {
    final request = ChangePasswordRequest(password: "old", newPassword: "new");
    final response = ChangePasswordResponse(message: "Success");

    test(
      'should return SuccessApiResult when remote data source is successful',
      () async {
        when(
          mockRemoteDataSource.changePassword(any),
        ).thenAnswer((_) async => SuccessApiResult(data: response));

        final result = await repository.changePassword(request);

        expect(result, isA<SuccessApiResult<ChangePasswordResponse>>());
        verify(mockRemoteDataSource.changePassword(request)).called(1);
      },
    );

    test(
      'should return ErrorApiResult when remote data source fails',
      () async {
        when(
          mockRemoteDataSource.changePassword(any),
        ).thenAnswer((_) async => ErrorApiResult(error: "Server Error"));

        final result = await repository.changePassword(request);

        expect(result, isA<ErrorApiResult<ChangePasswordResponse>>());
        verify(mockRemoteDataSource.changePassword(request)).called(1);
      },
    );
  });
}
