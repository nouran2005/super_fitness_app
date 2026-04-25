import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/api/datasources/meals_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';

import 'meals_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MealsRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = MealsRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group("MealsRemoteDataSourceImpl - getMealDetailsById", () {
    test('should return ApiSuccess when request succeeds', () async {
      final fakeDto = MealsDetailsDto();

      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/meals/details'),
          statusCode: 200,
        ),
      );

      when(
        mockApiClient.getMealDetailsById(any),
      ).thenAnswer((_) async => fakeResponse);
      final result =
          await dataSource.getMealDetailsById(1)
              as SuccessApiResult<MealsDetailsDto>;
      expect(result, isA<SuccessApiResult<MealsDetailsDto>>());
      expect(result.data, fakeDto);

      verify(mockApiClient.getMealDetailsById(any)).called(1);
    });

    test('should return ApiFailure when request throws exception', () async {
      when(
        mockApiClient.getMealDetailsById(any),
      ).thenThrow(Exception('Network error'));

      final result =
          await dataSource.getMealDetailsById(1)
              as ErrorApiResult<MealsDetailsDto>;

      expect(result, isA<ErrorApiResult<MealsDetailsDto>>());
      expect(result.error.toString(), contains("Network error"));
      verify(mockApiClient.getMealDetailsById(any)).called(1);
    });
  });
}
