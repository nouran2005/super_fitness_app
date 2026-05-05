import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_security_data_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepository;
  late GetSecurityDataUsecase useCase;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetSecurityDataUsecase(mockRepository);
  });

  group('GetSecurityDataUsecase', () {
    test('should delegate to repository and return String', () async {
      const tResult = 'Security content';
      when(
        () => mockRepository.securityData(),
      ).thenAnswer((_) async => tResult);

      final result = await useCase.call();

      expect(result, tResult);
      verify(() => mockRepository.securityData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository throws', () async {
      when(() => mockRepository.securityData()).thenThrow(Exception('Error'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
