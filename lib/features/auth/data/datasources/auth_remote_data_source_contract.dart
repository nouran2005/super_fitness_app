import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';

abstract class AuthRemoteDataSourceContract {
  Future<ApiResult<SignupDto>> signUp(SignupRequest request);
}
