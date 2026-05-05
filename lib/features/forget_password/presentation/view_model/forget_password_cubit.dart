import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/reset_password_usecase.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/verify_code_usecase.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_events.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._verifyCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(
        ForgetPasswordState(
          forgetPassword: Resource.initial(),
          verifyCode: Resource.initial(),
          resetPassword: Resource.initial(),
        ),
      );

  void onEvent(ForgetPasswordEvents event) {
    switch (event) {
      case ForgetPasswordProcessEvent():
        _forgetPassword(event.email);
      case VerifyCodeProcessEvent():
        _verifyCode(event.code);
      case ResetPasswordProcessEvent():
        _resetPassword(event.request);
    }
  }

  Future<void> _forgetPassword(String email) async {
    emit(state.copyWith(forgetPassword: Resource.loading()));
    final result = await _forgetPasswordUseCase(email);
    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(forgetPassword: Resource.success(result.data)));
      case ErrorApiResult():
        emit(state.copyWith(forgetPassword: Resource.error(result.error)));
    }
  }

  Future<void> _verifyCode(String code) async {
    emit(state.copyWith(verifyCode: Resource.loading()));
    final result = await _verifyCodeUseCase(code);
    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(verifyCode: Resource.success(result.data)));
      case ErrorApiResult():
        emit(state.copyWith(verifyCode: Resource.error(result.error)));
    }
  }

  Future<void> _resetPassword(ResetPasswordRequestModel request) async {
    emit(state.copyWith(resetPassword: Resource.loading()));
    final result = await _resetPasswordUseCase(request);
    switch (result) {
      case SuccessApiResult():
        emit(state.copyWith(resetPassword: Resource.success(result.data)));
      case ErrorApiResult():
        emit(state.copyWith(resetPassword: Resource.error(result.error)));
    }
  }
}
