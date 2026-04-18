import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'signup_intent.dart';
import 'signup_states.dart';

@injectable
class SignupCubit extends Cubit<SignupStates> {
  final SignupUseCase _signupUseCase;

  SignupCubit(this._signupUseCase) : super(SignupStates());

  void doIntent(SignupIntent intent) {
    if (intent is SetBasicInfo) {
      emit(
        state.copyWith(
          firstName: intent.firstName,
          lastName: intent.lastName,
          email: intent.email,
          password: intent.password,
        ),
      );
      return;
    }

    if (intent is MoveToPreviousStep) {
      _goPrevious();
      return;
    }

    if (intent is SetGender) {
      emit(state.copyWith(gender: intent.gender));
      return;
    }

    if (intent is SetAge) {
      emit(state.copyWith(age: intent.age));
      return;
    }

    if (intent is SetWeight) {
      emit(state.copyWith(weight: intent.weight));
      return;
    }

    if (intent is SetHeight) {
      emit(state.copyWith(height: intent.height));
      return;
    }

    if (intent is SetGoal) {
      emit(state.copyWith(goal: intent.goal));
      return;
    }

    if (intent is SetActivityLevel) {
      emit(state.copyWith(activityLevel: intent.activityLevel));
      return;
    }

    if (intent is PerformSignup) {
      _performSignup();
      return;
    }

    if (intent is MoveToNextStep) {
      _goNext();
      return;
    }
  }

  void _goPrevious() {
    final index = state.currentStep.index;
    if (index > 0) {
      emit(state.copyWith(currentStep: SignupStep.values[index - 1]));
    }
  }

  void _goNext() {
    final index = state.currentStep.index;
    if (index < SignupStep.values.length - 1) {
      emit(state.copyWith(currentStep: SignupStep.values[index + 1]));
    }
  }

  Future<void> _performSignup() async {
    emit(state.copyWith(signupResource: Resource.loading()));

    final result = await _signupUseCase.execute(
      firstName: state.firstName!,
      lastName: state.lastName!,
      email: state.email!,
      password: state.password!,
      rePassword: state.password!,
      gender: state.gender!,
      height: state.height!,
      weight: state.weight!,
      age: state.age!,
      goal: state.goal!,
      activityLevel: state.activityLevel!,
    );

    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(signupResource: Resource.success(result.data)));
        break;

      case ErrorApiResult():
        emit(state.copyWith(signupResource: Resource.error(result.error)));
        break;
    }
  }
}
