// TODO: api SigninRemoteDataSourceImpl

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';

@Injectable(as: SigninRemoteDataSourceContract)
class SigninRemoteDataSourceImpl implements SigninRemoteDataSourceContract {
  final ApiClient apiClient;
  SigninRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<SigninResponse>> signin(SigninPostModel loginRequest) {
    return safeApiCall<SigninResponse>(
      call: () => apiClient.signIn(loginRequest),
    );
  }
}
