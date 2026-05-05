import 'dart:io';

sealed class EditProfileEvents {}

class GetLoggedUserDataProcessEvent extends EditProfileEvents {}

class UpdateLocalFieldEvent extends EditProfileEvents {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? weight;
  final String? goal;
  final String? activityLevel;
  final bool isFormValid;

  UpdateLocalFieldEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.activityLevel,
    this.isFormValid = true,
  });
}

class UploadProfileImageProcessEvent extends EditProfileEvents {
  final File photo;
  UploadProfileImageProcessEvent(this.photo);
}

class SaveChangesProcessEvent extends EditProfileEvents {}
