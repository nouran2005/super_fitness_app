import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/api/datasources/work_out_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late WorkOutRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = WorkOutRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('WorkOutRemoteDataSourceImpl', () {
    test(
      'getAllMusclesGroup should return SuccessApiResult when apiClient returns success',
      () async {
        // arrange
        final tResponse = AllMusclesGroupResponse(musclesGroup: []);
        final httpResponse = HttpResponse(
          tResponse,
          Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
        );
        when(
          () => mockApiClient.getAllMusclesGroup(
            language: any(named: 'language'),
          ),
        ).thenAnswer((_) async => httpResponse);

        // act
        final result = await dataSource.getAllMusclesGroup(language: 'en');

        // assert
        expect(result, isA<SuccessApiResult<AllMusclesGroupResponse>>());
        expect((result as SuccessApiResult).data, tResponse);
      },
    );

    test(
      'getAllMusclesByMuscleGroup should return SuccessApiResult when apiClient returns success',
      () async {
        // arrange
        final tResponse = AllMusclesByMuscleGroupResponse(muscles: []);
        final httpResponse = HttpResponse(
          tResponse,
          Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
        );
        when(
          () => mockApiClient.getAllMusclesByMuscleGroup(
            language: any(named: 'language'),
            muscleGroupId: any(named: 'muscleGroupId'),
          ),
        ).thenAnswer((_) async => httpResponse);

        // act
        final result = await dataSource.getAllMusclesByMuscleGroup(
          language: 'en',
          muscleGroupId: '1',
        );

        // assert
        expect(
          result,
          isA<SuccessApiResult<AllMusclesByMuscleGroupResponse>>(),
        );
        expect((result as SuccessApiResult).data, tResponse);
      },
    );

    test(
      'should return ErrorApiResult when apiClient throws exception',
      () async {
        // arrange
        when(
          () => mockApiClient.getAllMusclesGroup(
            language: any(named: 'language'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'Network Error',
          ),
        );

        // act
        final result = await dataSource.getAllMusclesGroup(language: 'en');

        // assert
        expect(result, isA<ErrorApiResult>());
        expect((result as ErrorApiResult).error, contains('Network Error'));
      },
    );
  });
}
