import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/datasources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/auth/data/models/response/user_dto.dart';
import 'package:super_fitness_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthRemoteDataSourceContract {}

void main() {
  late MockAuthRemoteDataSource mockDataSource;
  late AuthRepositoryImpl repository;

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

  final tUserDto = UserModelDto(
    id: 'user123',
    firstName: tFirstName,
    lastName: tLastName,
    email: tEmail,
    gender: tGender,
    height: tHeight,
    weight: tWeight,
    role: 'user',
  );

  final tSignupDto = SignupDto(
    message: 'Registration successful',
    token: 'jwt_token_123',
    user: tUserDto,
  );

  setUpAll(() {
    registerFallbackValue(
      SignupRequest(
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
    );
  });

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockDataSource);
  });

  // ─── Helper to call repository.signUp ────────────────────────────────────────
  Future<ApiResult<SignupModel>> callSignUp() => repository.signUp(
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

  group('AuthRepositoryImpl.signUp', () {
    test(
      'should return SuccessApiResult<SignupModel> when datasource succeeds',
      () async {
        // arrange
        when(() => mockDataSource.signUp(any())).thenAnswer(
          (_) async => SuccessApiResult<SignupDto>(data: tSignupDto),
        );

        // act
        final result = await callSignUp();

        // assert
        expect(result, isA<SuccessApiResult<SignupModel>>());
        final data = (result as SuccessApiResult<SignupModel>).data;
        expect(data.id, 'user123');
        expect(data.firstName, tFirstName);
        expect(data.lastName, tLastName);
        expect(data.email, tEmail);
        expect(data.gender, tGender);
        expect(data.height, tHeight);
        expect(data.weight, tWeight);

        verify(() => mockDataSource.signUp(any())).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return ErrorApiResult<SignupModel> when datasource returns error',
      () async {
        // arrange
        const tErrorMessage = 'Email already in use';
        when(() => mockDataSource.signUp(any())).thenAnswer(
          (_) async => ErrorApiResult<SignupDto>(error: tErrorMessage),
        );

        // act
        final result = await callSignUp();

        // assert
        expect(result, isA<ErrorApiResult<SignupModel>>());
        expect((result as ErrorApiResult<SignupModel>).error, tErrorMessage);

        verify(() => mockDataSource.signUp(any())).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('should pass the correct SignupRequest to the datasource', () async {
      // arrange
      when(
        () => mockDataSource.signUp(any()),
      ).thenAnswer((_) async => SuccessApiResult<SignupDto>(data: tSignupDto));

      // act
      await callSignUp();

      // assert — capture the argument passed
      final captured = verify(
        () => mockDataSource.signUp(captureAny()),
      ).captured;
      final request = captured.first as SignupRequest;

      expect(request.firstName, tFirstName);
      expect(request.lastName, tLastName);
      expect(request.email, tEmail);
      expect(request.password, tPassword);
      expect(request.rePassword, tRePassword);
      expect(request.gender, tGender);
      expect(request.height, tHeight);
      expect(request.weight, tWeight);
      expect(request.age, tAge);
      expect(request.goal, tGoal);
      expect(request.activityLevel, tActivityLevel);
    });
  });
}
