import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_exercises_by_muscle_difficulty_usecase.dart';

class MockPopularTrainingRepo extends Mock implements PopularTrainingRepo {}

void main() {
  late MockPopularTrainingRepo mockRepo;
  late GetExercisesByMuscleDifficultyUseCase useCase;

  const tMuscleId = 'muscle_1';
  const tDifficultyId = 'difficulty_1';

  final tEntity = ExercisesByMuscleDifficultyResponseEntity(
    totalExercises: 2,
    exercises: [
      ExerciseEntity(
        id: '1',
        exercise: 'Push Up',
        difficultyLevel: 'Beginner',
        shortYoutubeDemonstration: '',
      ),
      ExerciseEntity(
        id: '2',
        exercise: 'Pull Up',
        difficultyLevel: 'Intermediate',
        shortYoutubeDemonstration: '',
      ),
    ],
  );

  setUp(() {
    mockRepo = MockPopularTrainingRepo();
    useCase = GetExercisesByMuscleDifficultyUseCase(mockRepo);
  });

  group('GetExercisesByMuscleDifficultyUseCase', () {
    test('should delegate to repository and return SuccessApiResult', () async {
      // arrange
      when(
        () => mockRepo.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
        ),
      ).thenAnswer((_) async => SuccessApiResult(data: tEntity));

      // act
      final result = await useCase(
        primeMoverMuscleId: tMuscleId,
        difficultyLevelId: tDifficultyId,
      );

      // assert
      expect(
        result,
        isA<SuccessApiResult<ExercisesByMuscleDifficultyResponseEntity>>(),
      );
      expect(
        (result as SuccessApiResult<ExercisesByMuscleDifficultyResponseEntity>)
            .data,
        tEntity,
      );
      verify(
        () => mockRepo.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
        ),
      ).called(1);
    });

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        // arrange
        const tError = 'Server error';
        when(
          () => mockRepo.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: any(named: 'primeMoverMuscleId'),
            difficultyLevelId: any(named: 'difficultyLevelId'),
          ),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        // act
        final result = await useCase(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
        );

        // assert
        expect(
          result,
          isA<ErrorApiResult<ExercisesByMuscleDifficultyResponseEntity>>(),
        );
        expect(
          (result as ErrorApiResult<ExercisesByMuscleDifficultyResponseEntity>)
              .error,
          tError,
        );
      },
    );
  });
}
