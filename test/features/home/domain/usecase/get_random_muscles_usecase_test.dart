import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';
import 'package:super_fitness_app/features/home/domain/repo/home_repo.dart';
import 'package:super_fitness_app/features/home/domain/usecase/get_random_muscles_usecase.dart';

import 'get_random_muscles_usecase_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late GetRandomMusclesUseCase useCase;
  late MockHomeRepo mockHomeRepo;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    useCase = GetRandomMusclesUseCase(mockHomeRepo);
  });

  test('should call getRandomMuscles from repository', () async {
    const recommendation = RecommendationEntity(message: 'Success');
    when(mockHomeRepo.getRandomMuscles()).thenAnswer((_) async => recommendation);

    final result = await useCase.execute();

    expect(result, recommendation);
    verify(mockHomeRepo.getRandomMuscles()).called(1);
    verifyNoMoreInteractions(mockHomeRepo);
  });
}
