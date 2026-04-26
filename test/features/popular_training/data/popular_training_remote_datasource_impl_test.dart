import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/api/datasources_impl/popular_training_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';

import 'popular_training_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late PopularTrainingRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = PopularTrainingRemoteDataSourceImpl(mockApiClient);
  });

  Response<T> fakeResponse<T>(T data) => Response<T>(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  group('getRandomMuscles', () {
    final tResponseModel = const MusclesRandomResponseModel(
      message: 'Success',
      totalMuscles: 0,
      muscles: [],
    );

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(mockApiClient.getRandom20Muscles()).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.getRandomMuscles();

        expect(result, isA<SuccessApiResult<MusclesRandomResponseModel>>());
        expect(
          (result as SuccessApiResult<MusclesRandomResponseModel>).data,
          tResponseModel,
        );
        verify(mockApiClient.getRandom20Muscles()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(mockApiClient.getRandom20Muscles()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'No internet connection',
          ),
        );

        final result = await dataSource.getRandomMuscles();

        expect(result, isA<ErrorApiResult<MusclesRandomResponseModel>>());
        expect(
          (result as ErrorApiResult<MusclesRandomResponseModel>).error,
          'No internet connection',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<MusclesRandomResponseModel>(
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.getRandom20Muscles(),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.getRandomMuscles();

        expect(result, isA<ErrorApiResult<MusclesRandomResponseModel>>());
        expect(
          (result as ErrorApiResult<MusclesRandomResponseModel>).error,
          'Failed with status code: 400',
        );
      },
    );
  });

  group('getLevels', () {
    final tResponseModel = const LevelsResponseModel(
      message: 'Success',
      levels: [],
    );

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(mockApiClient.getLevels()).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.getLevels();

        expect(result, isA<SuccessApiResult<LevelsResponseModel>>());
        expect(
          (result as SuccessApiResult<LevelsResponseModel>).data,
          tResponseModel,
        );
        verify(mockApiClient.getLevels()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(mockApiClient.getLevels()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'No internet connection',
          ),
        );

        final result = await dataSource.getLevels();

        expect(result, isA<ErrorApiResult<LevelsResponseModel>>());
        expect(
          (result as ErrorApiResult<LevelsResponseModel>).error,
          'No internet connection',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<LevelsResponseModel>(
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.getLevels(),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.getLevels();

        expect(result, isA<ErrorApiResult<LevelsResponseModel>>());
        expect(
          (result as ErrorApiResult<LevelsResponseModel>).error,
          'Failed with status code: 400',
        );
      },
    );
  });

  group('getExercisesByMuscleDifficulty', () {
    const tPrimeMoverMuscleId = 'muscle_1';
    const tDifficultyLevelId = 'level_1';
    final tResponseModel = const ExercisesByMuscleDifficultyResponseModel(
      message: 'Success',
      totalExercises: 0,
      exercises: [],
    );

    test(
      'should return SuccessApiResult when the API call completes successfully',
      () async {
        when(
          mockApiClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tPrimeMoverMuscleId,
            difficultyLevelId: tDifficultyLevelId,
          ),
        ).thenAnswer(
          (_) async =>
              HttpResponse(tResponseModel, fakeResponse(tResponseModel)),
        );

        final result = await dataSource.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tPrimeMoverMuscleId,
          difficultyLevelId: tDifficultyLevelId,
        );

        expect(
          result,
          isA<SuccessApiResult<ExercisesByMuscleDifficultyResponseModel>>(),
        );
        expect(
          (result as SuccessApiResult<ExercisesByMuscleDifficultyResponseModel>)
              .data,
          tResponseModel,
        );
        verify(
          mockApiClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tPrimeMoverMuscleId,
            difficultyLevelId: tDifficultyLevelId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorApiResult when the API throws a DioException',
      () async {
        when(
          mockApiClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tPrimeMoverMuscleId,
            difficultyLevelId: tDifficultyLevelId,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: 'No internet connection',
          ),
        );

        final result = await dataSource.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tPrimeMoverMuscleId,
          difficultyLevelId: tDifficultyLevelId,
        );

        expect(
          result,
          isA<ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>>(),
        );
        expect(
          (result as ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>)
              .error,
          'No internet connection',
        );
      },
    );

    test(
      'should return ErrorApiResult when API returns a non-2xx status code',
      () async {
        final badResponse = Response<ExercisesByMuscleDifficultyResponseModel>(
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        );
        when(
          mockApiClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tPrimeMoverMuscleId,
            difficultyLevelId: tDifficultyLevelId,
          ),
        ).thenAnswer((_) async => HttpResponse(tResponseModel, badResponse));

        final result = await dataSource.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tPrimeMoverMuscleId,
          difficultyLevelId: tDifficultyLevelId,
        );

        expect(
          result,
          isA<ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>>(),
        );
        expect(
          (result as ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>)
              .error,
          'Failed with status code: 400',
        );
      },
    );
  });
}
