import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepo _repo;

  EditProfileUseCase(this._repo);

  Future<ApiResult<LoggedUserDataResponseEntity>> editProfile(
    EditProfileRequestModel requestModel,
  ) {
    return _repo.editProfile(requestModel);
  }
}
