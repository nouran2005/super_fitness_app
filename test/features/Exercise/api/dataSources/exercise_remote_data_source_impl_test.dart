import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/api/dataScources/exercise_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ExerciseRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ExerciseRemoteDataSourceImpl(mockApiClient);
  });

  group('ExerciseRemoteDataSourceImpl', () {
    final tExerciseResponse = ExerciseResponse(
      message: 'success',
      exercises: [],
    );

    final tHttpResponse = HttpResponse(
      tExerciseResponse,
      Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
    );

    group('getExercises', () {
      test(
        'should return SuccessApiResult when ApiClient returns successfully',
        () async {
          // arrange
          when(
            () => mockApiClient.getExercises(language: any(named: 'language')),
          ).thenAnswer((_) async => tHttpResponse);

          // act
          final result = await dataSource.getExercises();

          // assert
          expect(result, isA<SuccessApiResult<ExerciseResponse>>());
          expect((result as SuccessApiResult).data, tExerciseResponse);
          verify(() => mockApiClient.getExercises(language: 'en')).called(1);
        },
      );

      test(
        'should return ErrorApiResult when ApiClient throws exception',
        () async {
          // arrange
          when(
            () => mockApiClient.getExercises(language: any(named: 'language')),
          ).thenThrow(Exception('error'));

          // act
          final result = await dataSource.getExercises();

          // assert
          expect(result, isA<ErrorApiResult<ExerciseResponse>>());
          verify(() => mockApiClient.getExercises(language: 'en')).called(1);
        },
      );
    });

    group('getExercisesRandom', () {
      const tMuscleGroupId = '1';
      const tDifficultyId = '1';

      test(
        'should return SuccessApiResult when ApiClient returns successfully',
        () async {
          // arrange
          when(
            () => mockApiClient.getExercisesRandom(
              language: any(named: 'language'),
              muscleGroupId: any(named: 'muscleGroupId'),
              difficultyId: any(named: 'difficultyId'),
            ),
          ).thenAnswer((_) async => tHttpResponse);

          // act
          final result = await dataSource.getExercisesRandom(
            muscleGroupId: tMuscleGroupId,
            difficultyId: tDifficultyId,
          );

          // assert
          expect(result, isA<SuccessApiResult<ExerciseResponse>>());
          expect((result as SuccessApiResult).data, tExerciseResponse);
          verify(
            () => mockApiClient.getExercisesRandom(
              language: 'en',
              muscleGroupId: tMuscleGroupId,
              difficultyId: tDifficultyId,
            ),
          ).called(1);
        },
      );

      test(
        'should return ErrorApiResult when ApiClient throws exception',
        () async {
          // arrange
          when(
            () => mockApiClient.getExercisesRandom(
              language: any(named: 'language'),
              muscleGroupId: any(named: 'muscleGroupId'),
              difficultyId: any(named: 'difficultyId'),
            ),
          ).thenThrow(Exception('error'));

          // act
          final result = await dataSource.getExercisesRandom(
            muscleGroupId: tMuscleGroupId,
            difficultyId: tDifficultyId,
          );

          // assert
          expect(result, isA<ErrorApiResult<ExerciseResponse>>());
        },
      );
    });
  });
}
