import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

abstract class ProfileRepository {
  Future<ApiResult<ProfileDataModel>> getProfileData(String token);
}
