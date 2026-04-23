import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/data/datasources/popular_training_remote_datasource.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/repos/popular_training_repo_impl.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';

import 'popular_training_repo_impl_test.mocks.dart';

@GenerateMocks([PopularTrainingRemoteDataSource])
void main() {
  late MockPopularTrainingRemoteDataSource mockDataSource;
  late PopularTrainingRepoImpl repo;

  setUp(() {
    mockDataSource = MockPopularTrainingRemoteDataSource();
    repo = PopularTrainingRepoImpl(mockDataSource);

    provideDummy<ApiResult<MusclesRandomResponseModel>>(
      SuccessApiResult(
        data: MusclesRandomResponseModel(
          message: '',
          totalMuscles: 0,
          muscles: [],
        ),
      ),
    );
    provideDummy<ApiResult<LevelsResponseModel>>(
      SuccessApiResult(
        data: LevelsResponseModel(message: '', levels: []),
      ),
    );
    provideDummy<ApiResult<ExercisesByMuscleDifficultyResponseModel>>(
      SuccessApiResult(
        data: ExercisesByMuscleDifficultyResponseModel(
          message: '',
          totalExercises: 0,
          exercises: [],
        ),
      ),
    );
  });

  group('getRandomMuscles', () {
    const tResponseModel = MusclesRandomResponseModel(
      message: 'Success',
      totalMuscles: 1,
      muscles: [RandomMuscleModel(id: '1', name: 'Biceps', image: 'image.png')],
    );
    final tEntity = const MusclesRandomEntity(ids: ['1']);
    const tErrorMessage = 'Something went wrong';

    test(
      'should return SuccessApiResult with a MusclesRandomEntity on success',
      () async {
        when(
          mockDataSource.getRandomMuscles(),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.getRandomMuscles();

        expect(result, isA<SuccessApiResult<MusclesRandomEntity>>());
        final success = result as SuccessApiResult<MusclesRandomEntity>;
        expect(success.data.ids, equals(tEntity.ids));
        verify(mockDataSource.getRandomMuscles()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(mockDataSource.getRandomMuscles()).thenAnswer(
          (_) async =>
              ErrorApiResult<MusclesRandomResponseModel>(error: tErrorMessage),
        );

        final result = await repo.getRandomMuscles();

        expect(result, isA<ErrorApiResult<MusclesRandomEntity>>());
        expect(
          (result as ErrorApiResult<MusclesRandomEntity>).error,
          tErrorMessage,
        );
      },
    );
  });

  group('getLevels', () {
    const tResponseModel = LevelsResponseModel(
      message: 'Success',
      levels: [LevelModel(id: '1', name: 'Beginner')],
    );
    final tEntity = const LevelsEntity(ids: ['1']);
    const tErrorMessage = 'Failed to load levels';

    test(
      'should return SuccessApiResult with a LevelsEntity on success',
      () async {
        when(
          mockDataSource.getLevels(),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.getLevels();

        expect(result, isA<SuccessApiResult<LevelsEntity>>());
        final success = result as SuccessApiResult<LevelsEntity>;
        expect(success.data.ids, equals(tEntity.ids));
        verify(mockDataSource.getLevels()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(mockDataSource.getLevels()).thenAnswer(
          (_) async =>
              ErrorApiResult<LevelsResponseModel>(error: tErrorMessage),
        );

        final result = await repo.getLevels();

        expect(result, isA<ErrorApiResult<LevelsEntity>>());
        expect((result as ErrorApiResult<LevelsEntity>).error, tErrorMessage);
      },
    );
  });

  group('getExercisesByMuscleDifficulty', () {
    const tPrimeMoverMuscleId = 'muscle_1';
    const tDifficultyLevelId = 'level_1';

    const tResponseModel = ExercisesByMuscleDifficultyResponseModel(
      message: 'Success',
      totalExercises: 1,
      exercises: [
        ExerciseByMuscleDifficultyModel(
          id: '1',
          exercise: 'Push up',
          difficultyLevel: 'Beginner',
          shortYoutubeDemonstration: 'url',
        ),
      ],
    );
    final tEntity = const ExercisesByMuscleDifficultyResponseEntity(
      exercises: [
        ExerciseEntity(
          id: '1',
          exercise: 'Push up',
          difficultyLevel: 'Beginner',
          shortYoutubeDemonstration: 'url',
        ),
      ],
    );
    const tErrorMessage = 'Error fetching exercises';

    test(
      'should return SuccessApiResult with an ExercisesByMuscleDifficultyResponseEntity on success',
      () async {
        when(
          mockDataSource.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseModel));

        final result = await repo.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tPrimeMoverMuscleId,
          difficultyLevelId: tDifficultyLevelId,
        );

        expect(
          result,
          isA<SuccessApiResult<ExercisesByMuscleDifficultyResponseEntity>>(),
        );
        final success =
            result
                as SuccessApiResult<ExercisesByMuscleDifficultyResponseEntity>;
        expect(success.data.exercises.length, 1);
        expect(success.data.exercises.first.id, tEntity.exercises.first.id);
        expect(
          success.data.exercises.first.exercise,
          tEntity.exercises.first.exercise,
        );
        verify(
          mockDataSource.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tPrimeMoverMuscleId,
            difficultyLevelId: tDifficultyLevelId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult with the error message on failure',
      () async {
        when(
          mockDataSource.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer(
          (_) async => ErrorApiResult<ExercisesByMuscleDifficultyResponseModel>(
            error: tErrorMessage,
          ),
        );

        final result = await repo.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tPrimeMoverMuscleId,
          difficultyLevelId: tDifficultyLevelId,
        );

        expect(
          result,
          isA<ErrorApiResult<ExercisesByMuscleDifficultyResponseEntity>>(),
        );
        expect(
          (result as ErrorApiResult<ExercisesByMuscleDifficultyResponseEntity>)
              .error,
          tErrorMessage,
        );
      },
    );
  });
}
