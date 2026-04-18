import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

final tSignupModel = SignupModel(
  id: 'user123',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  gender: 'male',
  height: 175,
  weight: 70,
  age: 25,
  goal: 'loseWeight',
  activityLevel: 'intermediate',
);

void main() {
  late MockSignupUseCase mockSignupUseCase;
  late SignupCubit cubit;

  setUp(() {
    mockSignupUseCase = MockSignupUseCase();
    cubit = SignupCubit(mockSignupUseCase);
  });

  tearDown(() => cubit.close());

  group('SignupCubit - initial state', () {
    test('initial state has correct defaults', () {
      expect(cubit.state.signupResource.status, Status.initial);
      expect(cubit.state.currentStep, SignupStep.basicInfo);
      expect(cubit.state.gender, isNull);
      expect(cubit.state.age, isNull);
      expect(cubit.state.weight, isNull);
      expect(cubit.state.height, isNull);
      expect(cubit.state.goal, isNull);
      expect(cubit.state.activityLevel, isNull);
    });
  });

  group('SetGender', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated gender when SetGender is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetGender('male')),
      expect: () => [
        isA<SignupStates>().having((s) => s.gender, 'gender', 'male'),
      ],
    );

    blocTest<SignupCubit, SignupStates>(
      'can switch gender from male to female',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) {
        c.doIntent(SetGender('male'));
        c.doIntent(SetGender('female'));
      },
      expect: () => [
        isA<SignupStates>().having((s) => s.gender, 'gender', 'male'),
        isA<SignupStates>().having((s) => s.gender, 'gender', 'female'),
      ],
    );
  });

  group('SetAge', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated age when SetAge is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetAge(25)),
      expect: () => [isA<SignupStates>().having((s) => s.age, 'age', 25)],
    );
  });

  group('SetWeight', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated weight when SetWeight is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetWeight(70)),
      expect: () => [isA<SignupStates>().having((s) => s.weight, 'weight', 70)],
    );
  });

  group('SetHeight', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated height when SetHeight is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetHeight(175)),
      expect: () => [
        isA<SignupStates>().having((s) => s.height, 'height', 175),
      ],
    );
  });

  group('SetGoal', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated goal when SetGoal is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetGoal('loseWeight')),
      expect: () => [
        isA<SignupStates>().having((s) => s.goal, 'goal', 'loseWeight'),
      ],
    );
  });

  group('SetActivityLevel', () {
    blocTest<SignupCubit, SignupStates>(
      'emits state with updated activityLevel when SetActivityLevel is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(SetActivityLevel('intermediate')),
      expect: () => [
        isA<SignupStates>().having(
          (s) => s.activityLevel,
          'activityLevel',
          'intermediate',
        ),
      ],
    );
  });

  group('MoveToNextStep', () {
    blocTest<SignupCubit, SignupStates>(
      'advances to next step when MoveToNextStep is called',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) => c.doIntent(MoveToNextStep()),
      expect: () => [
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'currentStep',
          SignupStep.gender,
        ),
      ],
    );

    blocTest<SignupCubit, SignupStates>(
      'does not go beyond last step',
      build: () => SignupCubit(mockSignupUseCase),
      seed: () => SignupStates(currentStep: SignupStep.activityLevel),
      act: (c) => c.doIntent(MoveToNextStep()),
      expect: () => [],
    );
  });

  group('MoveToPreviousStep', () {
    blocTest<SignupCubit, SignupStates>(
      'goes back to previous step when MoveToPreviousStep is called',
      build: () => SignupCubit(mockSignupUseCase),
      seed: () => SignupStates(currentStep: SignupStep.age),
      act: (c) => c.doIntent(MoveToPreviousStep()),
      expect: () => [
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'currentStep',
          SignupStep.gender, // age -> gender
        ),
      ],
    );

    blocTest<SignupCubit, SignupStates>(
      'does not go before first step',
      build: () => SignupCubit(mockSignupUseCase),
      seed: () => SignupStates(currentStep: SignupStep.basicInfo),
      act: (c) => c.doIntent(MoveToPreviousStep()),
      expect: () => [],
    );
  });

  group('PerformSignup', () {
    blocTest<SignupCubit, SignupStates>(
      'emits [loading, success] when PerformSignup succeeds',
      build: () {
        when(
          () => mockSignupUseCase.execute(
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

        return SignupCubit(mockSignupUseCase);
      },
      seed: () => SignupStates(
        currentStep: SignupStep.activityLevel,
        firstName: 'mariam',
        lastName: 'mohamed',
        email: 'mariam@gmail.com',
        password: 'Mariam@123',
        gender: 'female',
        age: 25,
        weight: 70,
        height: 175,
        goal: 'loseWeight',
        activityLevel: 'level1',
      ),
      act: (c) => c.doIntent(PerformSignup()),
      expect: () => [
        isA<SignupStates>().having(
          (s) => s.signupResource.status,
          'status',
          Status.loading,
        ),
        isA<SignupStates>().having(
          (s) => s.signupResource.status,
          'status',
          Status.success,
        ),
      ],
    );

    blocTest<SignupCubit, SignupStates>(
      'emits [loading, error] when PerformSignup fails',
      build: () {
        when(
          () => mockSignupUseCase.execute(
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
        ).thenAnswer((_) async => ErrorApiResult(error: 'Registration failed'));

        return SignupCubit(mockSignupUseCase);
      },
      seed: () => SignupStates(
        currentStep: SignupStep.activityLevel,
        firstName: 'mariam',
        lastName: 'mohamed',
        email: 'mariam@gmail.com',
        password: 'Mariam@123',
        gender: 'female',
        age: 25,
        weight: 70,
        height: 175,
        goal: 'loseWeight',
        activityLevel: 'level1',
      ),
      act: (c) => c.doIntent(PerformSignup()),
      expect: () => [
        isA<SignupStates>().having(
          (s) => s.signupResource.status,
          'status',
          Status.loading,
        ),
        isA<SignupStates>()
            .having((s) => s.signupResource.status, 'status', Status.error)
            .having(
              (s) => s.signupResource.error,
              'error',
              'Registration failed',
            ),
      ],
    );
  });

  group('Full signup flow', () {
    blocTest<SignupCubit, SignupStates>(
      'walks through all onboarding steps correctly',
      build: () => SignupCubit(mockSignupUseCase),
      act: (c) {
        c.doIntent(
          SetBasicInfo(
            firstName: 'mariam',
            lastName: 'mohamed',
            email: 'mariam@gmail.com',
            password: 'Mariam@123',
            rePassword: 'Mariam@123',
          ),
        );
        c.doIntent(MoveToNextStep());
        c.doIntent(SetGender('female'));
        c.doIntent(MoveToNextStep());
        c.doIntent(SetAge(25));
        c.doIntent(MoveToNextStep());
        c.doIntent(SetWeight(70));
        c.doIntent(MoveToNextStep());
        c.doIntent(SetHeight(175));
        c.doIntent(MoveToNextStep());
        c.doIntent(SetGoal('loseWeight'));
        c.doIntent(MoveToNextStep());
        c.doIntent(SetActivityLevel('level1'));
      },
      expect: () => [
        isA<SignupStates>().having((s) => s.firstName, 'firstName', 'mariam'),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.gender,
        ),
        isA<SignupStates>().having((s) => s.gender, 'gender', 'female'),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.age,
        ),
        isA<SignupStates>().having((s) => s.age, 'age', 25),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.weight,
        ),
        isA<SignupStates>().having((s) => s.weight, 'weight', 70),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.height,
        ),
        isA<SignupStates>().having((s) => s.height, 'height', 175),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.goal,
        ),
        isA<SignupStates>().having((s) => s.goal, 'goal', 'loseWeight'),
        isA<SignupStates>().having(
          (s) => s.currentStep,
          'step',
          SignupStep.activityLevel,
        ),
        isA<SignupStates>().having(
          (s) => s.activityLevel,
          'activityLevel',
          'level1',
        ),
      ],
    );
  });
}
