import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/changePassword/data/datasources/change_password_remote_datasource.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final ApiClient _apiClient;

  ChangePasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  ) {
    return safeApiCall<ChangePasswordResponse>(
      call: () => _apiClient.changePassword(request),
    );
  }
}
