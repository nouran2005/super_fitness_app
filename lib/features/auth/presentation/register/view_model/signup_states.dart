import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';

class SignupStates {
  final Resource<SignupModel> signupResource;
  final SignupStep currentStep;

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;
  final String? activityLevel;

  SignupStates({
    Resource<SignupModel>? signupResource,
    this.currentStep = SignupStep.basicInfo,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  }) : signupResource = signupResource ?? Resource.initial();

  SignupStates copyWith({
    Resource<SignupModel>? signupResource,
    SignupStep? currentStep,
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? password,
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
  }) {
    return SignupStates(
      signupResource: signupResource ?? this.signupResource,
      currentStep: currentStep ?? this.currentStep,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}
