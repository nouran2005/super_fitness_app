import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_levels_usecase.dart';

class MockPopularTrainingRepo extends Mock implements PopularTrainingRepo {}

void main() {
  late MockPopularTrainingRepo mockRepo;
  late GetLevelsUseCase useCase;

  final tEntity = LevelsEntity(ids: ['level_1', 'level_2', 'level_3']);

  setUp(() {
    mockRepo = MockPopularTrainingRepo();
    useCase = GetLevelsUseCase(mockRepo);
  });

  group('GetLevelsUseCase', () {
    test('should delegate to repository and return SuccessApiResult', () async {
      // arrange
      when(
        () => mockRepo.getLevels(),
      ).thenAnswer((_) async => SuccessApiResult(data: tEntity));

      // act
      final result = await useCase.getLevels();

      // assert
      expect(result, isA<SuccessApiResult<LevelsEntity>>());
      expect((result as SuccessApiResult<LevelsEntity>).data, tEntity);
      verify(() => mockRepo.getLevels()).called(1);
    });

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        // arrange
        const tError = 'Server error';
        when(
          () => mockRepo.getLevels(),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        // act
        final result = await useCase.getLevels();

        // assert
        expect(result, isA<ErrorApiResult<LevelsEntity>>());
        expect((result as ErrorApiResult<LevelsEntity>).error, tError);
      },
    );
  });
}
