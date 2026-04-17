import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/auth/data/datasources/auth_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSourceContract {
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<SignupDto>> signUp(SignupRequest request) {
    return safeApiCall(call: () => apiClient.signUp(request));
  }
}
