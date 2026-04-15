// TODO: data SigninRepositoryImpl

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_local_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';
import 'package:super_fitness_app/features/signin/domain/repositories/signin_repository.dart';

@Injectable(as: SigninRepository)
class SigninRepositoryImpl implements SigninRepository {
  final SigninLocalDataSourceContract signinLocalDataSource;
  final SigninRemoteDataSourceContract signinRemoteDataSourceContract;

  SigninRepositoryImpl({
    required this.signinLocalDataSource,
    required this.signinRemoteDataSourceContract,
  });

  @override
  Future<ApiResult<SigninEntity>> signin(SigninPostModel postModel) async {
    final result = await signinRemoteDataSourceContract.signin(postModel);
    switch (result) {
      case SuccessApiResult<SigninResponse>():
        await signinLocalDataSource.cachedToken(result.data.token ?? "");
        return SuccessApiResult<SigninEntity>(
          data: result.data.toSigninEntity(),
        );
      case ErrorApiResult<SigninResponse>():
        return ErrorApiResult<SigninEntity>(error: result.error);
    }
  }
}
