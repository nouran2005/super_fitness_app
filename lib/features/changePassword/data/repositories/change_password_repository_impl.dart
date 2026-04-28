import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/datasources/change_password_remote_datasource.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/changePassword/domain/repositories/change_password_repository.dart';

@Injectable(as: ChangePasswordRepository)
class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource _remoteDataSource;

  ChangePasswordRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  ) {
    return _remoteDataSource.changePassword(request);
  }
}
