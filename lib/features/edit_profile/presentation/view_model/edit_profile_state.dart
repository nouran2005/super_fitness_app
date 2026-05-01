import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';

class EditProfileState {
  final LoggedUserEntity? originalUser;
  final LoggedUserEntity? updatedUser;
  final bool isFormValid;
  final bool isPhotoUploading;
  final bool isSavingData;
  final Resource<LoggedUserDataResponseEntity> getLoggedUserData;
  final String? saveError;

  const EditProfileState({
    this.originalUser,
    this.updatedUser,
    this.isFormValid = true,
    this.isPhotoUploading = false,
    this.isSavingData = false,
    required this.getLoggedUserData,
    this.saveError,
  });

  EditProfileState copyWith({
    LoggedUserEntity? originalUser,
    LoggedUserEntity? updatedUser,
    bool? isFormValid,
    bool? isPhotoUploading,
    bool? isSavingData,
    Resource<LoggedUserDataResponseEntity>? getLoggedUserData,
    String? saveError,
    bool clearSaveError = false,
  }) {
    return EditProfileState(
      originalUser: originalUser ?? this.originalUser,
      updatedUser: updatedUser ?? this.updatedUser,
      isFormValid: isFormValid ?? this.isFormValid,
      isPhotoUploading: isPhotoUploading ?? this.isPhotoUploading,
      isSavingData: isSavingData ?? this.isSavingData,
      getLoggedUserData: getLoggedUserData ?? this.getLoggedUserData,
      saveError: clearSaveError ? null : (saveError ?? this.saveError),
    );
  }
}
