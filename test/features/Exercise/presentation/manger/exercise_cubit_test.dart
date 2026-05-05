import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_random_use_case.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_use_case.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([GetExercisesUseCase, GetExercisesRandomUseCase])
void main() {
  late MockGetExercisesUseCase mockGetExercisesUseCase;
  late MockGetExercisesRandomUseCase mockGetExercisesRandomUseCase;
  late ExerciseCubit cubit;

  setUpAll(() {
    provideDummy<ApiResult<ExerciseResponseEntity>>(
        SuccessApiResult<ExerciseResponseEntity>(
        data: ExerciseResponseEntity(),
      ),
    );
  });

  setUp(() {
    mockGetExercisesUseCase = MockGetExercisesUseCase();
    mockGetExercisesRandomUseCase = MockGetExercisesRandomUseCase();
    cubit = ExerciseCubit(mockGetExercisesUseCase, mockGetExercisesRandomUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('ExerciseCubit', () {
    const exerciseEntity = ExerciseEntity(id: '1', exercise: 'Pushup');
    const categoryEntity = ExerciseCategoryEntity(name: 'Chest', exercises: [exerciseEntity]);
    const responseEntity = ExerciseResponseEntity(categories: [categoryEntity]);

    blocTest<ExerciseCubit, ExerciseStates>(
      'calls _getExercises and emits success state on GetExercisesIntent',
      build: () {
        when(mockGetExercisesUseCase.execute()).thenAnswer(
          (_) async => SuccessApiResult<ExerciseResponseEntity>(data: responseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetExercisesIntent()),
      expect: () => [
        isA<ExerciseStates>().having((s) => s.exerciseResource.status, 'status', Status.loading),
        isA<ExerciseStates>().having((s) => s.exerciseResource.status, 'status', Status.success)
                             .having((s) => s.exerciseResource.data, 'data', responseEntity),
      ],
      verify: (_) {
        verify(mockGetExercisesUseCase.execute()).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseStates>(
      'calls _getExercises and emits error state on GetExercisesIntent',
      build: () {
        when(mockGetExercisesUseCase.execute()).thenAnswer(
          (_) async =>   ErrorApiResult<ExerciseResponseEntity>(error: 'Error loading exercises'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetExercisesIntent()),
      expect: () => [
        isA<ExerciseStates>().having((s) => s.exerciseResource.status, 'status', Status.loading),
        isA<ExerciseStates>().having((s) => s.exerciseResource.status, 'status', Status.error)
                             .having((s) => s.exerciseResource.error, 'error', 'Error loading exercises'),
      ],
      verify: (_) {
        verify(mockGetExercisesUseCase.execute()).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseStates>(
      'calls _getExercisesRandom and emits success state on GetExercisesRandomIntent',
      build: () {
        when(mockGetExercisesRandomUseCase.execute(muscleGroupId: 'm1', difficultyId: 'd1')).thenAnswer(
          (_) async =>   SuccessApiResult<ExerciseResponseEntity>(data: responseEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetExercisesRandomIntent(muscleGroupId: 'm1', difficultyId: 'd1')),
      expect: () => [
        isA<ExerciseStates>().having((s) => s.currentExercisesResource.status, 'status', Status.loading),
        isA<ExerciseStates>().having((s) => s.currentExercisesResource.status, 'status', Status.success)
                             .having((s) => s.currentExercisesResource.data, 'data', [exerciseEntity]),
      ],
      verify: (_) {
        verify(mockGetExercisesRandomUseCase.execute(muscleGroupId: 'm1', difficultyId: 'd1')).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseStates>(
      'calls _getExercisesRandom and emits error state on GetExercisesRandomIntent',
      build: () {
        when(mockGetExercisesRandomUseCase.execute(muscleGroupId: 'm1', difficultyId: 'd1')).thenAnswer(
          (_) async =>   ErrorApiResult<ExerciseResponseEntity>(error: 'Error loading random exercises'),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetExercisesRandomIntent(muscleGroupId: 'm1', difficultyId: 'd1')),
      expect: () => [
        isA<ExerciseStates>().having((s) => s.currentExercisesResource.status, 'status', Status.loading),
        isA<ExerciseStates>().having((s) => s.currentExercisesResource.status, 'status', Status.error)
                             .having((s) => s.currentExercisesResource.error, 'error', 'Error loading random exercises'),
      ],
      verify: (_) {
        verify(mockGetExercisesRandomUseCase.execute(muscleGroupId: 'm1', difficultyId: 'd1')).called(1);
      },
    );
  });
}
