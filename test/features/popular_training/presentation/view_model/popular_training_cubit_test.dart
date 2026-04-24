import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_exercises_by_muscle_difficulty_usecase.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_levels_usecase.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_events.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';

import 'popular_training_cubit_test.mocks.dart';

@GenerateMocks([
  GetRandomMusclesUseCase,
  GetLevelsUseCase,
  GetExercisesByMuscleDifficultyUseCase,
])
void main() {
  late MockGetRandomMusclesUseCase mockGetRandomMusclesUseCase;
  late MockGetLevelsUseCase mockGetLevelsUseCase;
  late MockGetExercisesByMuscleDifficultyUseCase mockGetExercisesUseCase;
  late PopularTrainingCubit cubit;

  setUp(() {
    mockGetRandomMusclesUseCase = MockGetRandomMusclesUseCase();
    mockGetLevelsUseCase = MockGetLevelsUseCase();
    mockGetExercisesUseCase = MockGetExercisesByMuscleDifficultyUseCase();

    provideDummy<ApiResult<MusclesRandomEntity>>(
      SuccessApiResult(data: const MusclesRandomEntity(muscles: [])),
    );
    provideDummy<ApiResult<LevelsEntity>>(
      SuccessApiResult(data: const LevelsEntity(ids: [])),
    );
    provideDummy<ApiResult<ExercisesByMuscleDifficultyResponseEntity>>(
      SuccessApiResult(
        data: const ExercisesByMuscleDifficultyResponseEntity(
          exercises: [],
          totalExercises: 0,
        ),
      ),
    );

    cubit = PopularTrainingCubit(
      mockGetRandomMusclesUseCase,
      mockGetLevelsUseCase,
      mockGetExercisesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('PopularTrainingCubit', () {
    const tErrorMessage = 'An error occurred';
    final tMuscleEntity = const MuscleEntity(
      id: '1',
      name: 'Biceps',
      image: 'image.png',
    );
    final tMusclesEntity = MusclesRandomEntity(muscles: [tMuscleEntity]);
    final tLevelsEntity = const LevelsEntity(ids: ['1']);
    final tExerciseEntity = const ExerciseEntity(
      id: '1',
      exercise: 'Curls',
      difficultyLevel: 'Beginner',
      shortYoutubeDemonstration: 'url',
    );
    final tExercisesResponse = ExercisesByMuscleDifficultyResponseEntity(
      exercises: [tExerciseEntity],
      totalExercises: 1,
    );

    test('initial state should be Resource.initial()', () {
      expect(cubit.state.popularExercises.isInitial, true);
    });

    test('emits [loading, error] when getRandomMuscles fails', () async {
      when(
        mockGetRandomMusclesUseCase.getRandomMuscles(),
      ).thenAnswer((_) async => ErrorApiResult(error: tErrorMessage));
      when(
        mockGetLevelsUseCase.getLevels(),
      ).thenAnswer((_) async => SuccessApiResult(data: tLevelsEntity));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<PopularTrainingState>().having(
            (s) => s.popularExercises.isLoading,
            'isLoading',
            true,
          ),
          isA<PopularTrainingState>().having(
            (s) => s.popularExercises.isError,
            'isError',
            true,
          ),
        ]),
      );

      cubit.onEvent(LoadPopularTrainingExercisesEvent());
    });

    test('emits [loading, error] when getLevels fails', () async {
      when(
        mockGetRandomMusclesUseCase.getRandomMuscles(),
      ).thenAnswer((_) async => SuccessApiResult(data: tMusclesEntity));
      when(
        mockGetLevelsUseCase.getLevels(),
      ).thenAnswer((_) async => ErrorApiResult(error: tErrorMessage));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<PopularTrainingState>().having(
            (s) => s.popularExercises.isLoading,
            'isLoading',
            true,
          ),
          isA<PopularTrainingState>().having(
            (s) => s.popularExercises.isError,
            'isError',
            true,
          ),
        ]),
      );

      cubit.onEvent(LoadPopularTrainingExercisesEvent());
    });

    test('emits [loading, error] when muscles or levels are empty', () async {
      when(mockGetRandomMusclesUseCase.getRandomMuscles()).thenAnswer(
        (_) async =>
            SuccessApiResult(data: const MusclesRandomEntity(muscles: [])),
      );
      when(
        mockGetLevelsUseCase.getLevels(),
      ).thenAnswer((_) async => SuccessApiResult(data: tLevelsEntity));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<PopularTrainingState>().having(
            (s) => s.popularExercises.isLoading,
            'isLoading',
            true,
          ),
          isA<PopularTrainingState>()
              .having((s) => s.popularExercises.isError, 'isError', true)
              .having(
                (s) => s.popularExercises.error,
                'error message',
                'No muscles or levels available.',
              ),
        ]),
      );

      cubit.onEvent(LoadPopularTrainingExercisesEvent());
    });

    test(
      'emits [loading, success] with 15 exercises when APIs succeed',
      () async {
        when(
          mockGetRandomMusclesUseCase.getRandomMuscles(),
        ).thenAnswer((_) async => SuccessApiResult(data: tMusclesEntity));
        when(
          mockGetLevelsUseCase.getLevels(),
        ).thenAnswer((_) async => SuccessApiResult(data: tLevelsEntity));
        when(
          mockGetExercisesUseCase(
            primeMoverMuscleId: anyNamed('primeMoverMuscleId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tExercisesResponse));

        expectLater(
          cubit.stream,
          emitsInOrder([
            isA<PopularTrainingState>().having(
              (s) => s.popularExercises.isLoading,
              'isLoading',
              true,
            ),
            isA<PopularTrainingState>()
                .having((s) => s.popularExercises.isSuccess, 'isSuccess', true)
                .having((s) => s.popularExercises.data?.length, 'length', 15),
          ]),
        );

        cubit.onEvent(LoadPopularTrainingExercisesEvent());
      },
    );
  });
}
