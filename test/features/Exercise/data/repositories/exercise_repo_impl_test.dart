import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/data/dataScources/exercise_remote_data_source.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';
import 'package:super_fitness_app/features/Exercise/data/repo/exercise_repo_impl.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class MockExerciseRemoteDataSource extends Mock
    implements ExerciseRemoteDataSource {}

void main() {
  late ExerciseRepoImpl repository;
  late MockExerciseRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockExerciseRemoteDataSource();
    repository = ExerciseRepoImpl(mockRemoteDataSource);
  });

  group('ExerciseRepoImpl', () {
    final tExerciseResponse = ExerciseResponse(
      message: 'success',
      exercises: [Exercise(exercise: 'Push Up', difficultyLevel: 'Beginner')],
    );

    group('getExercises', () {
      test(
        'should return SuccessApiResult<ExerciseResponseEntity> when datasource succeeds',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getExercises(),
          ).thenAnswer((_) async => SuccessApiResult(data: tExerciseResponse));

          // act
          final result = await repository.getExercises();

          // assert
          expect(result, isA<SuccessApiResult<ExerciseResponseEntity>>());
          final data =
              (result as SuccessApiResult).data as ExerciseResponseEntity;
          expect(data.exercises?[0].exercise, 'Push Up');
          verify(() => mockRemoteDataSource.getExercises()).called(1);
        },
      );

      test(
        'should return ErrorApiResult<ExerciseResponseEntity> when datasource fails',
        () async {
          // arrange
          const tError = 'error message';
          when(
            () => mockRemoteDataSource.getExercises(),
          ).thenAnswer((_) async => ErrorApiResult(error: tError));

          // act
          final result = await repository.getExercises();

          // assert
          expect(result, isA<ErrorApiResult<ExerciseResponseEntity>>());
          expect((result as ErrorApiResult).error, tError);
          verify(() => mockRemoteDataSource.getExercises()).called(1);
        },
      );
    });

    group('getExercisesRandom', () {
      const tMuscleGroupId = '1';
      const tDifficultyId = '1';

      test(
        'should return SuccessApiResult<ExerciseResponseEntity> when datasource succeeds',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getExercisesRandom(
              muscleGroupId: any(named: 'muscleGroupId'),
              difficultyId: any(named: 'difficultyId'),
            ),
          ).thenAnswer((_) async => SuccessApiResult(data: tExerciseResponse));

          // act
          final result = await repository.getExercisesRandom(
            muscleGroupId: tMuscleGroupId,
            difficultyId: tDifficultyId,
          );

          // assert
          expect(result, isA<SuccessApiResult<ExerciseResponseEntity>>());
          final data =
              (result as SuccessApiResult).data as ExerciseResponseEntity;
          expect(data.exercises?[0].exercise, 'Push Up');
          verify(
            () => mockRemoteDataSource.getExercisesRandom(
              muscleGroupId: tMuscleGroupId,
              difficultyId: tDifficultyId,
            ),
          ).called(1);
        },
      );

      test(
        'should return ErrorApiResult<ExerciseResponseEntity> when datasource fails',
        () async {
          // arrange
          const tError = 'error message';
          when(
            () => mockRemoteDataSource.getExercisesRandom(
              muscleGroupId: any(named: 'muscleGroupId'),
              difficultyId: any(named: 'difficultyId'),
            ),
          ).thenAnswer((_) async => ErrorApiResult(error: tError));

          // act
          final result = await repository.getExercisesRandom(
            muscleGroupId: tMuscleGroupId,
            difficultyId: tDifficultyId,
          );

          // assert
          expect(result, isA<ErrorApiResult<ExerciseResponseEntity>>());
          expect((result as ErrorApiResult).error, tError);
        },
      );
    });
  });
}
