import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/get_logged_user_data_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final GetLoggedUserDataUseCase _getLoggedUserDataUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  EditProfileCubit(
    this._editProfileUseCase,
    this._getLoggedUserDataUseCase,
    this._uploadProfileImageUseCase,
  ) : super(EditProfileState(getLoggedUserData: Resource.initial()));

  bool get isSaveEnabled =>
      (state.originalUser != state.updatedUser) &&
      state.isFormValid &&
      !state.isSavingData;

  void onEvent(EditProfileEvents event) {
    switch (event) {
      case GetLoggedUserDataProcessEvent():
        _fetchInitialData();
      case UpdateLocalFieldEvent():
        _updateLocalField(event);
      case UploadProfileImageProcessEvent():
        _uploadProfileImage(event.photo);
      case SaveChangesProcessEvent():
        _saveChanges();
    }
  }

  Future<void> _fetchInitialData() async {
    emit(state.copyWith(getLoggedUserData: Resource.loading()));

    final result = await _getLoggedUserDataUseCase.getLoggedUserData();
    switch (result) {
      case SuccessApiResult():
        final user = result.data.user;
        emit(
          state.copyWith(
            getLoggedUserData: Resource.success(result.data),
            originalUser: user,
            updatedUser: user,
            isFormValid: true,
          ),
        );
      case ErrorApiResult():
        emit(state.copyWith(getLoggedUserData: Resource.error(result.error)));
    }
  }

  void _updateLocalField(UpdateLocalFieldEvent event) {
    if (state.updatedUser == null) return;

    final updated = state.updatedUser!.copyWith(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      weight: event.weight,
      goal: event.goal,
      activityLevel: event.activityLevel,
    );

    emit(state.copyWith(updatedUser: updated, isFormValid: event.isFormValid));
  }

  Future<void> _uploadProfileImage(File photo) async {
    emit(state.copyWith(isPhotoUploading: true));
    final result = await _uploadProfileImageUseCase.uploadImage(photo);
    switch (result) {
      case SuccessApiResult():
        await _fetchInitialData();
        emit(state.copyWith(isPhotoUploading: false));
      case ErrorApiResult():
        emit(state.copyWith(isPhotoUploading: false, saveError: result.error));
    }
  }

  Future<void> _saveChanges() async {
    if (!isSaveEnabled) return;

    final updated = state.updatedUser!;

    emit(state.copyWith(isSavingData: true, clearSaveError: true));

    final request = EditProfileRequestModel(
      firstName: updated.firstName,
      lastName: updated.lastName,
      email: updated.email,
      weight: updated.weight,
      goal: updated.goal,
      activityLevel: updated.activityLevel,
    );

    final result = await _editProfileUseCase.editProfile(request);

    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(isSavingData: false, originalUser: updated));
      case ErrorApiResult():
        emit(state.copyWith(isSavingData: false, saveError: result.error));
    }
  }
}
