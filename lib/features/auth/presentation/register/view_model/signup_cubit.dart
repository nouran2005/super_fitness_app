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
    if (intent is MoveToPreviousStep) {
      _goPrevious();
      return;
    }

    if (intent is SetGender) {
      emit(state.copyWith(gender: intent.gender, currentStep: SignupStep.age));
      return;
    }

    if (intent is SetAge) {
      emit(state.copyWith(age: intent.age, currentStep: SignupStep.weight));
      return;
    }

    if (intent is SetWeight) {
      emit(
        state.copyWith(weight: intent.weight, currentStep: SignupStep.height),
      );
      return;
    }

    if (intent is SetHeight) {
      emit(state.copyWith(height: intent.height, currentStep: SignupStep.goal));
      return;
    }

    if (intent is SetGoal) {
      emit(
        state.copyWith(
          goal: intent.goal,
          currentStep: SignupStep.activityLevel,
        ),
      );
      return;
    }

    if (intent is SetActivityLevel) {
      emit(state.copyWith(activityLevel: intent.activityLevel));
      return;
    }

    if (intent is PerformSignup) {
      _performSignup();
    }
  }

  void _goPrevious() {
    final index = state.currentStep.index;
    if (index > 0) {
      emit(state.copyWith(currentStep: SignupStep.values[index - 1]));
    }
  }

  Future<void> _performSignup() async {
    emit(state.copyWith(signupResource: Resource.loading()));

    final result = await _signupUseCase.execute(
      firstName: state.signupResource.data?.firstName ?? '',
      lastName: state.signupResource.data?.lastName ?? '',
      email: state.signupResource.data?.email ?? '',
      password: state.signupResource.data?.email ?? '',
      rePassword: state.signupResource.data?.email ?? '',
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
