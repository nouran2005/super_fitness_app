import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

class ProfileState {
  final Resource<ProfileDataModel> profileData;
  final String languageCode;
  final Resource<String>? help;
  final Resource<String>? security;
  final Resource<String>? privacy;

  ProfileState({
    Resource<ProfileDataModel>? profileData,
    this.languageCode = 'en',
    this.help,
    this.security,
    this.privacy,
  }) : profileData = profileData ?? Resource.initial();

  ProfileState copyWith({
    Resource<ProfileDataModel>? profileData,
    String? languageCode,
    Resource<String>? help,
    Resource<String>? security,
    Resource<String>? privacy,
  }) {
    return ProfileState(
      profileData: profileData ?? this.profileData,
      languageCode: languageCode ?? this.languageCode,
      help: help ?? this.help,
      security: security ?? this.security,
      privacy: privacy ?? this.privacy,
    );
  }
}
