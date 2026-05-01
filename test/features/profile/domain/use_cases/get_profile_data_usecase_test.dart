import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_profile_data_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepository;
  late GetProfileDataUsecase useCase;

  final tProfileDataModel = ProfileDataModel(
    user: ProfileUserModel(
      id: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      gender: 'male',
      height: 175,
      weight: 70,
      activityLevel: 'intermediate',
      goal: 'loseWeight',
      photo: 'photo_url',
      createdAt: '2023-01-01',
    ),
    message: 'Success',
    error: '',
  );

  const tToken = 'test_token';

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetProfileDataUsecase(repo: mockRepository);
  });

  group('GetProfileDataUsecase', () {
    test('should delegate to repository and return SuccessApiResult', () async {
      when(
        () => mockRepository.getProfileData(any()),
      ).thenAnswer((_) async => SuccessApiResult(data: tProfileDataModel));

      final result = await useCase.call(token: tToken);

      expect(result, isA<SuccessApiResult<ProfileDataModel>>());
      expect(
        (result as SuccessApiResult<ProfileDataModel>).data,
        tProfileDataModel,
      );
      verify(() => mockRepository.getProfileData(tToken)).called(1);
    });

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        const tError = 'Server error';
        when(
          () => mockRepository.getProfileData(any()),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        final result = await useCase.call(token: tToken);

        expect(result, isA<ErrorApiResult<ProfileDataModel>>());
        expect((result as ErrorApiResult<ProfileDataModel>).error, tError);
      },
    );
  });
}
