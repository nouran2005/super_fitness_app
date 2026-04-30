import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';

@injectable
class UploadProfileImageUseCase {
  final EditProfileRepo _repo;

  UploadProfileImageUseCase(this._repo);

  Future<ApiResult<String>> uploadImage(File photo) {
    return _repo.uploadImage(photo);
  }
}
