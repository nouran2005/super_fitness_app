import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_random_muscles_usecase.dart';

class MockPopularTrainingRepo extends Mock implements PopularTrainingRepo {}

void main() {
  late MockPopularTrainingRepo mockRepo;
  late GetRandomMusclesUseCase useCase;

  final tEntity = MusclesRandomEntity(
    muscles: [
      const MuscleEntity(id: '1', name: 'Chest', image: 'chest_url'),
      const MuscleEntity(id: '2', name: 'Back', image: 'back_url'),
    ],
  );

  setUp(() {
    mockRepo = MockPopularTrainingRepo();
    useCase = GetRandomMusclesUseCase(mockRepo);
  });

  group('GetRandomMusclesUseCase', () {
    test('should delegate to repository and return SuccessApiResult', () async {
      // arrange
      when(
        () => mockRepo.getRandomMuscles(),
      ).thenAnswer((_) async => SuccessApiResult(data: tEntity));

      // act
      final result = await useCase.getRandomMuscles();

      // assert
      expect(result, isA<SuccessApiResult<MusclesRandomEntity>>());
      expect((result as SuccessApiResult<MusclesRandomEntity>).data, tEntity);
      verify(() => mockRepo.getRandomMuscles()).called(1);
    });

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        // arrange
        const tError = 'Server error';
        when(
          () => mockRepo.getRandomMuscles(),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        // act
        final result = await useCase.getRandomMuscles();

        // assert
        expect(result, isA<ErrorApiResult<MusclesRandomEntity>>());
        expect((result as ErrorApiResult<MusclesRandomEntity>).error, tError);
      },
    );
  });
}
