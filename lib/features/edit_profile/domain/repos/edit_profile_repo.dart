import 'dart:io';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';

abstract interface class EditProfileRepo {
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData();

  Future<ApiResult<LoggedUserDataResponseEntity>> editProfile(
    EditProfileRequestModel requestModel,
  );

  Future<ApiResult<String>> uploadImage(File photo);
}
