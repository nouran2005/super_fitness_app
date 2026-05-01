import 'dart:io';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<ApiResult<LoggedUserDataResponseModel>> getLoggedUserData();

  Future<ApiResult<LoggedUserDataResponseModel>> editProfile(
    EditProfileRequestModel requestModel,
  );

  Future<ApiResult<String>> uploadImage(File photo);
}
