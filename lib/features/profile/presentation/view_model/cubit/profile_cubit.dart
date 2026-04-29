import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_help_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_privacy_policy_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_profile_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_security_data_usecase.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthStorage _authStorage;
  final GetProfileDataUsecase _profileUsecase;
  final GetHelpDataUsecase _helpUsecase;
  final GetPrivacyPolicyDataUsecase _privacyUsecase;
  final GetSecurityDataUsecase _securityUsecase;

  ProfileCubit(
    this._authStorage,
    this._profileUsecase,
    this._helpUsecase,
    this._privacyUsecase,
    this._securityUsecase,
  ) : super(ProfileState());

  void doIntent(ProfileEvent intent) {
    if (intent is ProfileDataEvent) {
      _profileData();
    }
    if (intent is ChangeLanguageEvent) {
      _toggleLanguage();
    }
    if (intent is HelpDataEvent) {
      _loadHelpData();
    }
    if (intent is PrivacyDataEvent) {
      _loadPrivacyPolicyData();
    }
    if (intent is SecurityDataEvent) {
      _loadSecurityData();
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

  Future<void> _loadHelpData() async {
    emit(state.copyWith(help: Resource.loading()));
    try {
      final data = await _helpUsecase.call();
      emit(state.copyWith(help: Resource.success(data)));
    } catch (e) {
      emit(state.copyWith(help: Resource.error(e.toString())));
    }
  }

  Future<void> _loadPrivacyPolicyData() async {
    emit(state.copyWith(help: Resource.loading()));
    try {
      final data = await _privacyUsecase.call();
      emit(state.copyWith(help: Resource.success(data)));
    } catch (e) {
      emit(state.copyWith(help: Resource.error(e.toString())));
    }
  }

  Future<void> _loadSecurityData() async {
    emit(state.copyWith(help: Resource.loading()));
    try {
      final data = await _securityUsecase.call();
      emit(state.copyWith(help: Resource.success(data)));
    } catch (e) {
      emit(state.copyWith(help: Resource.error(e.toString())));
    }
  }
}
