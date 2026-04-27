import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

extension ProfileDataDtoExtension on ProfileDataDto {
  ProfileDataModel toProfileDataModel() {
    return ProfileDataModel(
      error: error,
      message: message,
      user: user?.toProfileUserModel(),
    );
  }
}

extension ProfileUserDtoExtension on ProfileUserDto {
  ProfileUserModel toProfileUserModel() {
    return ProfileUserModel(
      age: age,
      activityLevel: activityLevel,
      createdAt: createdAt,
      email: email,
      firstName: firstName,
      gender: gender,
      goal: goal,
      height: height,
      id: id,
      lastName: lastName,
      photo: photo,
      resetCodeVerified: resetCodeVerified,
      weight: weight,
    );
  }
}
