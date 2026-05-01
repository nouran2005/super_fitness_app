import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/edit_profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';

@LazySingleton(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<LoggedUserDataResponseModel>> getLoggedUserData() {
    return safeApiCall(call: () => _apiClient.getLoggedUserData());
  }

  @override
  Future<ApiResult<LoggedUserDataResponseModel>> editProfile(
    EditProfileRequestModel requestModel,
  ) {
    return safeApiCall(call: () => _apiClient.editProfile(requestModel));
  }

  @override
  Future<ApiResult<String>> uploadImage(File photo) {
    return safeApiCall(call: () => _apiClient.uploadImage(photo));
  }
}
