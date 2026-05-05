import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/repo/exercise_repo.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_use_case.dart';

import 'get_exercises_use_case_test.mocks.dart';

@GenerateMocks([ExerciseRepo])
void main() {
  late MockExerciseRepo mockRepository;
  late GetExercisesUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<ExerciseResponseEntity>>(
        SuccessApiResult<ExerciseResponseEntity>(
        data: ExerciseResponseEntity(),
      ),
    );
  });

  setUp(() {
    mockRepository = MockExerciseRepo();
    useCase = GetExercisesUseCase(mockRepository);
  });

  test('should call repository.getExercises and return success result', () async {
    const entity = ExerciseResponseEntity(
      message: 'Success',
      totalExercises: 10,
    );

    when(mockRepository.getExercises())
        .thenAnswer((_) async => SuccessApiResult<ExerciseResponseEntity>(data: entity));

    // Act
    final result = await useCase.execute();

    // Assert
    expect(result, isA<SuccessApiResult<ExerciseResponseEntity>>());

    final success = result as SuccessApiResult<ExerciseResponseEntity>;
    expect(success.data.message, 'Success');
    expect(success.data.totalExercises, 10);

    verify(mockRepository.getExercises()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when repository fails', () async {
    when(mockRepository.getExercises())
        .thenAnswer((_) async => ErrorApiResult(error: 'Failed to fetch exercises'));

    // Act
    final result = await useCase.execute();

    // Assert
    expect(result, isA<ErrorApiResult>());

    final error = result as ErrorApiResult;
    expect(error.error, 'Failed to fetch exercises');

    verify(mockRepository.getExercises()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
