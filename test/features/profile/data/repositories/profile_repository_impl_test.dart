import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/values/api_constants.dart';
import 'package:super_fitness_app/features/profile/data/datasources/profile_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';
import 'package:super_fitness_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSourceContract {}

void main() {
  late MockProfileRemoteDataSource mockDataSource;
  late ProfileRepositoryImpl repository;

  final tUserDto = ProfileUserDto(
    id: '123',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    gender: 'male',
    height: 175,
    weight: 70,
    goal: 'loseWeight',
  );

  final tProfileDto = ProfileDataDto(message: 'Success', user: tUserDto);

  const tToken = 'Bearer test_token';

  setUp(() {
    mockDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('ProfileRepositoryImpl', () {
    test(
      'getProfileData should return SuccessApiResult<ProfileDataModel> when datasource succeeds',
      () async {
        when(() => mockDataSource.getProfileData(any())).thenAnswer(
          (_) async => SuccessApiResult<ProfileDataDto>(data: tProfileDto),
        );

        final result = await repository.getProfileData(tToken);

        expect(result, isA<SuccessApiResult<ProfileDataModel>>());
        final data = (result as SuccessApiResult<ProfileDataModel>).data;
        expect(data.user?.id, '123');
        expect(data.user?.firstName, 'John');
        expect(data.user?.lastName, 'Doe');
        expect(data.user?.email, 'john@example.com');

        verify(() => mockDataSource.getProfileData(tToken)).called(1);
      },
    );

    test(
      'getProfileData should return ErrorApiResult<ProfileDataModel> when datasource fails',
      () async {
        const tErrorMessage = 'Not found';
        when(() => mockDataSource.getProfileData(any())).thenAnswer(
          (_) async => ErrorApiResult<ProfileDataDto>(error: tErrorMessage),
        );

        final result = await repository.getProfileData(tToken);

        expect(result, isA<ErrorApiResult<ProfileDataModel>>());
        expect(
          (result as ErrorApiResult<ProfileDataModel>).error,
          tErrorMessage,
        );

        verify(() => mockDataSource.getProfileData(tToken)).called(1);
      },
    );

    test('helpData should return data from datasource', () async {
      when(
        () => mockDataSource.helpData(),
      ).thenAnswer((_) async => ApiConstants.helpDataLink);
      final result = await repository.helpData();
      expect(result, ApiConstants.helpDataLink);
      verify(() => mockDataSource.helpData()).called(1);
    });

    test('privacyData should return data from datasource', () async {
      when(
        () => mockDataSource.privacyData(),
      ).thenAnswer((_) async => ApiConstants.privacyLink);
      final result = await repository.privacyData();
      expect(result, ApiConstants.privacyLink);
      verify(() => mockDataSource.privacyData()).called(1);
    });

    test('securityData should return data from datasource', () async {
      when(
        () => mockDataSource.securityData(),
      ).thenAnswer((_) async => ApiConstants.securityLink);
      final result = await repository.securityData();
      expect(result, ApiConstants.securityLink);
      verify(() => mockDataSource.securityData()).called(1);
    });
  });
}
