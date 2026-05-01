import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_privacy_policy_data_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepository;
  late GetPrivacyPolicyDataUsecase useCase;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetPrivacyPolicyDataUsecase(mockRepository);
  });

  group('GetPrivacyPolicyDataUsecase', () {
    test('should delegate to repository and return String', () async {
      const tResult = 'Privacy Policy content';
      when(() => mockRepository.privacyData()).thenAnswer((_) async => tResult);

      final result = await useCase.call();

      expect(result, tResult);
      verify(() => mockRepository.privacyData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository throws', () async {
      when(() => mockRepository.privacyData()).thenThrow(Exception('Error'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
