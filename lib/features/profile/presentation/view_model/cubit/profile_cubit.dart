import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_profile_data_usecase.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthStorage _authStorage;
  final GetProfileDataUsecase _profileUsecase;

  ProfileCubit(this._authStorage, this._profileUsecase) : super(ProfileState());

  void doIntent(ProfileEvent intent) {
    if (intent is ProfileDataEvent) {
      _profileData();
    }
    if (intent is ChangeLanguageEvent) {
      _toggleLanguage();
    }
  }

  Future<void> _profileData() async {
    emit(state.copyWith(profileData: Resource.loading()));

    final token = await _authStorage.getToken();
    if (token == null) {
      emit(state.copyWith(profileData: Resource.error('Token not found')));
      return;
    }
    final result = await _profileUsecase.call(token: "Bearer $token");
    switch (result) {
      case SuccessApiResult<ProfileDataModel>():
        emit(state.copyWith(profileData: Resource.success(result.data)));

      case ErrorApiResult<ProfileDataModel>():
        emit(
          state.copyWith(profileData: Resource.error(result.error.toString())),
        );
    }
  }

  void _toggleLanguage() {
    final newLang = state.languageCode == 'en' ? 'ar' : 'en';
    emit(state.copyWith(languageCode: newLang));
  }
}
