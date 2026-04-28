import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/domain/use_cases/change_password_usecase.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_intent.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_state.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/core/widgets/loading_overlay/loading_overlay.dart';


@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCase _useCase;
  final AuthStorage _authStorage;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ChangePasswordCubit(this._useCase, this._authStorage)
      : super(ChangePasswordStates(changePasswordResource: Resource.initial()));


  void doIntent(ChangePasswordIntent intent) {
    if (intent is ChangePasswordSubmitIntent) {
      _changePassword();
    }
  }

  Future<void> _changePassword() async {
    showLoadingDialog();
    emit(state.copyWith(changePasswordResource: Resource.loading()));
    final request = ChangePasswordRequest(
      password: oldPasswordController.text,
      newPassword: newPasswordController.text,
    );

    final result = await _useCase.execute(request);
    hideLoadingDialog();

    switch (result) {
      case SuccessApiResult():
        if (result.data.token != null) {
          await _authStorage.saveToken(result.data.token!);
        }
        emit(
          state.copyWith(
            changePasswordResource: Resource.success(result.data),
          ),
        );

      case ErrorApiResult():
        emit(
          state.copyWith(
            changePasswordResource: Resource.error(result.error),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
