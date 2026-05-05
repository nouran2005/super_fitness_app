import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_state.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> {
  final LogoutUsecase _logoutUseCase;
  final AuthStorage _authStorage;

  LogoutCubit(this._logoutUseCase, this._authStorage) : super(LogoutStates());

  void doIntent(LogoutIntent intent) {
    switch (intent) {
      case PerformLogout():
        _performLogout();
        break;
    }
  }

  Future<void> _performLogout() async {
    emit(state.copyWith(logoutResource: Resource.loading()));
    final token = await _authStorage.getToken();
    if (token == null || token.isEmpty) {
      emit(state.copyWith(logoutResource: Resource.error("Token not found")));
      return;
    }
    final result = await _logoutUseCase.call(token: 'Bearer $token');
    switch (result) {
      case SuccessApiResult<LogoutResponse>():
        await _authStorage.clearAll();
        emit(state.copyWith(logoutResource: Resource.success(result.data)));
        break;
      case ErrorApiResult<LogoutResponse>():
        emit(state.copyWith(logoutResource: Resource.error(result.error)));
        break;
    }
  }
}
