import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/datasources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSourceContract remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
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
  }) async {
    final request = SignupRequest(
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
    final signupResponse = await remoteDataSource.signUp(request);

    switch (signupResponse) {
      case SuccessApiResult<SignupDto>():
        SignupDto dto = signupResponse.data;
        SignupModel signupModel = dto.toSignupModel();
        return SuccessApiResult<SignupModel>(data: signupModel);
      case ErrorApiResult<SignupDto>():
        return ErrorApiResult<SignupModel>(
          error: signupResponse.error.toString(),
        );
    }
  }

  @override
  Future<ApiResult<LogoutResponse>> logout({required String token}) async {
    final result = await remoteDataSource.logout(token: token);
    if (result is SuccessApiResult<LogoutResponse>) {
      return SuccessApiResult<LogoutResponse>(data: result.data);
    }
    if (result is ErrorApiResult<LogoutResponse>) {
      return ErrorApiResult<LogoutResponse>(error: result.error);
    }
    return ErrorApiResult<LogoutResponse>(error: 'Unexpected error');
  }
}
