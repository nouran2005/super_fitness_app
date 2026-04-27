import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<ApiResult<ProfileDataDto>> getProfileData(String token);
}
