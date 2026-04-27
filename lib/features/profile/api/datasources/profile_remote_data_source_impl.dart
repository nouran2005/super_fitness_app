import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/profile/data/datasources/profile_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSourceContract {
  final ApiClient apiClient;
  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<ProfileDataDto>> getProfileData(String token) {
    return safeApiCall(call: () => apiClient.getProfileData(token));
  }
}
