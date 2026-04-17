import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late SignupUseCase useCase;

  // ─── Shared test data ────────────────────────────────────────────────────────
  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tEmail = 'john@example.com';
  const tPassword = 'Password1!';
  const tRePassword = 'Password1!';
  const tGender = 'male';
  const tHeight = 175;
  const tWeight = 70;
  const tAge = 25;
  const tGoal = 'loseWeight';
  const tActivityLevel = 'intermediate';

  final tSignupModel = SignupModel(
    id: 'user123',
    firstName: tFirstName,
    lastName: tLastName,
    email: tEmail,
    gender: tGender,
    height: tHeight,
    weight: tWeight,
    age: tAge,
    goal: tGoal,
    activityLevel: tActivityLevel,
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignupUseCase(mockRepository);
  });

  // ─── Helper ──────────────────────────────────────────────────────────────────
  Future<ApiResult<SignupModel>> callExecute() => useCase.execute(
    firstName: tFirstName,
    lastName: tLastName,
    email: tEmail,
    password: tPassword,
    rePassword: tRePassword,
    gender: tGender,
    height: tHeight,
    weight: tWeight,
    age: tAge,
    goal: tGoal,
    activityLevel: tActivityLevel,
  );

  group('SignupUseCase.execute', () {
    test(
      'should delegate to repository.signUp and return SuccessApiResult',
      () async {
        // arrange
        when(
          () => mockRepository.signUp(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            rePassword: any(named: 'rePassword'),
            gender: any(named: 'gender'),
            height: any(named: 'height'),
            weight: any(named: 'weight'),
            age: any(named: 'age'),
            goal: any(named: 'goal'),
            activityLevel: any(named: 'activityLevel'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tSignupModel));

        // act
        final result = await callExecute();

        // assert
        expect(result, isA<SuccessApiResult<SignupModel>>());
        expect((result as SuccessApiResult<SignupModel>).data, tSignupModel);

        verify(
          () => mockRepository.signUp(
            firstName: tFirstName,
            lastName: tLastName,
            email: tEmail,
            password: tPassword,
            rePassword: tRePassword,
            gender: tGender,
            height: tHeight,
            weight: tWeight,
            age: tAge,
            goal: tGoal,
            activityLevel: tActivityLevel,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        // arrange
        const tError = 'Server error';
        when(
          () => mockRepository.signUp(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            rePassword: any(named: 'rePassword'),
            gender: any(named: 'gender'),
            height: any(named: 'height'),
            weight: any(named: 'weight'),
            age: any(named: 'age'),
            goal: any(named: 'goal'),
            activityLevel: any(named: 'activityLevel'),
          ),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        // act
        final result = await callExecute();

        // assert
        expect(result, isA<ErrorApiResult<SignupModel>>());
        expect((result as ErrorApiResult<SignupModel>).error, tError);
      },
    );
  });
}
