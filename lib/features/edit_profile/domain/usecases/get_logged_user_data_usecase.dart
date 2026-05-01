import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';

@injectable
class GetLoggedUserDataUseCase {
  final EditProfileRepo _repo;

  GetLoggedUserDataUseCase(this._repo);

  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() {
    return _repo.getLoggedUserData();
  }
}
