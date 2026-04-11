// TODO: presentation SigninCubit

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/widgets/loading_overlay/loading_overlay.dart';
import 'package:super_fitness_app/app/core/widgets/toast/custom_toast.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_events.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/main.dart';
import 'package:toastification/toastification.dart';

@injectable
class SigninCubit extends Cubit<SigninStates> {
  SigninCubit({required this.signinUseCase})
    : super(SigninStates(loginResource: Resource.initial()));
  final SigninUseCase signinUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void doIntent(SigninEvents event) {
    switch (event) {
      case SigninEvent():
        signIn();
    }
  }

  Future<void> signIn() async {
    showLoadingDialog();
    final result = await signinUseCase.execute(
      SigninPostModel(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    hideLoadingDialog();
    switch (result) {
      case SuccessApiResult<SigninEntity>():
        showToast(
          title: LocaleKeys.success.tr(),
          description:
              "${LocaleKeys.welcomeBack.tr()} ${result.data.firstName} ${result.data.lastName}!",
          type: ToastificationType.success,
        );
        // navigatorKey.currentContext?.push(RouteNames);
        // return;
        break;
      case ErrorApiResult<SigninEntity>():
        showToast(
          title: LocaleKeys.error.tr(),
          description: (result as ErrorApiResult).error,
          type: ToastificationType.error,
        );
        break;
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
