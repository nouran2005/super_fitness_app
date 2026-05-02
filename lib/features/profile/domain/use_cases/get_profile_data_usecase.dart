import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfileDataUsecase {
  final ProfileRepository repo;
  GetProfileDataUsecase({required this.repo});

  Future<ApiResult<ProfileDataModel>> call({required String token}) async {
    return await repo.getProfileData(token);
  }
}
