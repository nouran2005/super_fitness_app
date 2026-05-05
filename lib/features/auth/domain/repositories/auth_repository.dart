import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';

abstract class AuthRepository {
  Future<ApiResult<SignupModel>> signUp({
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
  });

  Future<ApiResult<LogoutResponse>> logout({required String token});
}
