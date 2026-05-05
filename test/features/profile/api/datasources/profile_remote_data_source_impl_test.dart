import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/values/api_constants.dart';
import 'package:super_fitness_app/features/profile/api/datasources/profile_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ProfileRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group("ProfileRemoteDataSourceImpl", () {
    const tToken = "Bearer test_token";

    group("getProfileData", () {
      test(
        'getProfileData should return SuccessApiResult when successful',
        () async {
          final fakeDto = ProfileDataDto(
            message: 'Success',
            user: ProfileUserDto(
              id: '123',
              firstName: 'mariam',
              lastName: 'mohamed',
              email: 'mariam@gmail.com',
              gender: 'female',
              height: 163,
              weight: 66,
              goal: 'loseWeight',
            ),
          );
          final fakeResponse = HttpResponse(
            fakeDto,
            Response(
              requestOptions: RequestOptions(path: '/users/profile'),
              statusCode: 200,
            ),
          );
          when(
            () => mockApiClient.getProfileData(tToken),
          ).thenAnswer((_) async => fakeResponse);

          final result =
              await dataSource.getProfileData(tToken)
                  as SuccessApiResult<ProfileDataDto>;

          expect(result, isA<SuccessApiResult<ProfileDataDto>>());
          expect(result.data.user!.email, fakeDto.user!.email);
          verify(() => mockApiClient.getProfileData(tToken)).called(1);
        },
      );

      test(
        'getProfileData should return ErrorApiResult when exception thrown',
        () async {
          when(
            () => mockApiClient.getProfileData(tToken),
          ).thenThrow(Exception('Network error'));

          final result =
              await dataSource.getProfileData(tToken)
                  as ErrorApiResult<ProfileDataDto>;

          expect(result, isA<ErrorApiResult<ProfileDataDto>>());
          expect(result.error.toString(), contains("Network error"));
          verify(() => mockApiClient.getProfileData(tToken)).called(1);
        },
      );
    });

    group('help, privacy and security data', () {
      test('helpData should return correct link', () async {
        final result = await dataSource.helpData();
        expect(result, ApiConstants.helpDataLink);
      });

      test('privacyData should return correct link', () async {
        final result = await dataSource.privacyData();
        expect(result, ApiConstants.privacyLink);
      });

      test('securityData should return correct link', () async {
        final result = await dataSource.securityData();
        expect(result, ApiConstants.securityLink);
      });
    });
  });
}
