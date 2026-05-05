import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/validation/app_validation.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/password_form_field.dart';
import 'package:super_fitness_app/app/core/widgets/show_snak_bar.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_events.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ResetPasswordCard extends StatefulWidget {
  const ResetPasswordCard({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordCard> createState() => _ResetPasswordCardState();
}

class _ResetPasswordCardState extends State<ResetPasswordCard> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onDone() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgetPasswordCubit>().onEvent(
        ResetPasswordProcessEvent(
          ResetPasswordRequestModel(
            email: widget.email,
            newPassword: _newPasswordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.resetPassword != current.resetPassword,
      listener: (context, state) {
        if (state.resetPassword.isError) {
          showAppSnackbar(
            context,
            state.resetPassword.error ?? '',
            backgroundColor: AppColors.error,
          );
        } else if (state.resetPassword.isSuccess) {
          showAppSnackbar(
            context,
            LocaleKeys.passwordResetSuccess.tr(),
            backgroundColor: AppColors.success,
          );
          context.go(RouteNames.signIn);
        }
      },
      buildWhen: (previous, current) =>
          previous.resetPassword != current.resetPassword,
      builder: (context, state) {
        final isLoading = state.resetPassword.isLoading;

        return GlassBlurContainer(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          backgroundColor: AppColors.white.withValues(alpha: 0.05),
          blurSigma: 15,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PasswordFormField(
                  controller: _newPasswordController,
                  enabled: !isLoading,
                  hintText: LocaleKeys.password.tr(),
                  validator: Validators.passwordValidator,
                ),

                SizedBox(height: mq.size.height * 0.02),

                PasswordFormField(
                  controller: _confirmPasswordController,
                  enabled: !isLoading,
                  hintText: LocaleKeys.confirmPassword.tr(),
                  validator: (val) => Validators.confirmPasswordValidator(
                    val,
                    _newPasswordController.text,
                  ),
                ),

                SizedBox(height: mq.size.height * 0.03),

                SizedBox(
                  width: double.infinity,
                  height: mq.size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onDone,
                    child: Text(LocaleKeys.done.tr()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
