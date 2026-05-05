import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<ApiResult<SignupModel>> execute({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  }) {
    return _repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );
  }
}
