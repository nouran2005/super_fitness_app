import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/repositories/work_out_repository.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_group_use_case.dart';

class MockWorkOutRepository extends Mock implements WorkOutRepository {}

void main() {
  late GetAllMusclesGroupUseCase useCase;
  late MockWorkOutRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkOutRepository();
    useCase = GetAllMusclesGroupUseCase(mockRepository);
  });

  group('GetAllMusclesGroupUseCase', () {
    test('should call getAllMusclesGroup on repository', () async {
      // arrange
      final tResult = SuccessApiResult(
        data: AllMusclesGroupResponseEntity(musclesGroup: []),
      );
      when(
        () =>
            mockRepository.getAllMusclesGroup(language: any(named: 'language')),
      ).thenAnswer((_) async => tResult);

      // act
      final result = await useCase.execute(language: 'en');

      // assert
      expect(result, tResult);
      verify(() => mockRepository.getAllMusclesGroup(language: 'en')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
