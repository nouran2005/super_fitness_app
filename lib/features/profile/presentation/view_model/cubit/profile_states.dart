import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

class ProfileState {
  final Resource<ProfileDataModel> profileData;
  final String languageCode;

  ProfileState({
    Resource<ProfileDataModel>? profileData,
    this.languageCode = 'en',
  }) : profileData = profileData ?? Resource.initial();

  ProfileState copyWith({
    Resource<ProfileDataModel>? profileData,
    String? languageCode,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
