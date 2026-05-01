import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_help_data_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepository;
  late GetHelpDataUsecase useCase;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetHelpDataUsecase(mockRepository);
  });

  group('GetHelpDataUsecase', () {
    test('should delegate to repository and return String', () async {
      const tResult = 'Help content';
      when(() => mockRepository.helpData()).thenAnswer((_) async => tResult);

      final result = await useCase.call();

      expect(result, tResult);
      verify(() => mockRepository.helpData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository throws', () async {
      when(() => mockRepository.helpData()).thenThrow(Exception('Error'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
