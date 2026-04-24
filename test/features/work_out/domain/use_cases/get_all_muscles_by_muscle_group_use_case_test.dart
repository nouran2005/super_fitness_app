import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/repositories/work_out_repository.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_by_muscle_group_use_case.dart';

class MockWorkOutRepository extends Mock implements WorkOutRepository {}

void main() {
  late GetAllMusclesByMuscleGroupUseCase useCase;
  late MockWorkOutRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkOutRepository();
    useCase = GetAllMusclesByMuscleGroupUseCase(mockRepository);
  });

  group('GetAllMusclesByMuscleGroupUseCase', () {
    test('should call getAllMusclesByMuscleGroup on repository', () async {
      // arrange
      final tResult = SuccessApiResult(
        data: AllMusclesByMuscleGroupResponseEntity(muscles: []),
      );
      when(
        () => mockRepository.getAllMusclesByMuscleGroup(
          language: any(named: 'language'),
          muscleGroupId: any(named: 'muscleGroupId'),
        ),
      ).thenAnswer((_) async => tResult);

      // act
      final result = await useCase.execute(language: 'en', muscleGroupId: '1');

      // assert
      expect(result, tResult);
      verify(
        () => mockRepository.getAllMusclesByMuscleGroup(
          language: 'en',
          muscleGroupId: '1',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
