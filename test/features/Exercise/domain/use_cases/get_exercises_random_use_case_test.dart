import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/repo/exercise_repo.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_random_use_case.dart';

import 'get_exercises_use_case_test.mocks.dart';

void main() {
  late MockExerciseRepo mockRepository;
  late GetExercisesRandomUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<ExerciseResponseEntity>>(
        SuccessApiResult<ExerciseResponseEntity>(
        data: ExerciseResponseEntity(),
      ),
    );
  });

  setUp(() {
    mockRepository = MockExerciseRepo();
    useCase = GetExercisesRandomUseCase(mockRepository);
  });

  test('should call repository.getExercisesRandom and return success result', () async {
    const entity = ExerciseResponseEntity(
      message: 'Success',
      totalExercises: 5,
    );

    when(mockRepository.getExercisesRandom(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    )).thenAnswer((_) async => SuccessApiResult<ExerciseResponseEntity>(data: entity));

    // Act
    final result = await useCase.execute(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    );

    // Assert
    expect(result, isA<SuccessApiResult<ExerciseResponseEntity>>());

    final success = result as SuccessApiResult<ExerciseResponseEntity>;
    expect(success.data.message, 'Success');
    expect(success.data.totalExercises, 5);

    verify(mockRepository.getExercisesRandom(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when repository fails', () async {
    when(mockRepository.getExercisesRandom(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    )).thenAnswer((_) async => ErrorApiResult(error: 'Failed to fetch random exercises'));

    // Act
    final result = await useCase.execute(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    );

    // Assert
    expect(result, isA<ErrorApiResult>());

    final error = result as ErrorApiResult;
    expect(error.error, 'Failed to fetch random exercises');

    verify(mockRepository.getExercisesRandom(
      muscleGroupId: 'muscle1',
      difficultyId: 'diff1',
    )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
