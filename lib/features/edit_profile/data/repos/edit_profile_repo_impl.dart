import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';

@LazySingleton(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() async {
    final result = await _remoteDataSource.getLoggedUserData();

    switch (result) {
      case SuccessApiResult<LoggedUserDataResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<LoggedUserDataResponseModel>():
        return ErrorApiResult<LoggedUserDataResponseEntity>(
          error: result.error,
        );
    }
  }

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> editProfile(
    EditProfileRequestModel requestModel,
  ) async {
    final result = await _remoteDataSource.editProfile(requestModel);

    switch (result) {
      case SuccessApiResult<LoggedUserDataResponseModel>():
        return SuccessApiResult(data: result.data.toEntity());
      case ErrorApiResult<LoggedUserDataResponseModel>():
        return ErrorApiResult<LoggedUserDataResponseEntity>(
          error: result.error,
        );
    }
  }

  @override
  Future<ApiResult<String>> uploadImage(File photo) async {
    final result = await _remoteDataSource.uploadImage(photo);

    switch (result) {
      case SuccessApiResult<String>():
        return SuccessApiResult(data: result.data);
      case ErrorApiResult<String>():
        return ErrorApiResult<String>(error: result.error);
    }
  }
}
