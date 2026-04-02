// TODO: data SigninRemoteDataSourceContract

import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';

abstract class SigninRemoteDataSourceContract {
  Future<ApiResult<SigninResponse>> signin(SigninPostModel loginRequest);
}
