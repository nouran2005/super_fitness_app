import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/show_snak_bar.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_events.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/otp_fields.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/resend_code_section.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class VerifyResetCodeCard extends StatefulWidget {
  const VerifyResetCodeCard({super.key, required this.email});

  final String email;

  @override
  State<VerifyResetCodeCard> createState() => _VerifyResetCodeCardState();
}

class _VerifyResetCodeCardState extends State<VerifyResetCodeCard> {
  final _otpController = PinInputController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_otpController.text.length == OtpFields.otpLength) {
      context.read<ForgetPasswordCubit>().onEvent(
        VerifyCodeProcessEvent(_otpController.text),
      );
    } else {
      showAppSnackbar(
        context,
        LocaleKeys.pleaseEnterTheCompleteOtpCode.tr(),
        backgroundColor: AppColors.error,
      );
    }
  }

  void _onResend() {
    _otpController.clear();
    context.read<ForgetPasswordCubit>().onEvent(
      ForgetPasswordProcessEvent(widget.email),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.verifyCode != current.verifyCode,
      listener: (context, state) {
        if (state.verifyCode.isError) {
          showAppSnackbar(
            context,
            state.verifyCode.error ?? '',
            backgroundColor: AppColors.error,
          );
        } else if (state.verifyCode.isSuccess) {
          context.go(RouteNames.resetPassword, extra: widget.email);
        }
      },
      buildWhen: (previous, current) =>
          previous.verifyCode != current.verifyCode,
      builder: (context, state) {
        final isVerifyLoading = state.verifyCode.isLoading;

        return GlassBlurContainer(
          padding: EdgeInsets.all(mq.size.width * 0.04),
          backgroundColor: AppColors.white.withValues(alpha: 0.05),
          blurSigma: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OtpFields(
                controller: _otpController,
                enabled: !isVerifyLoading,
                onCompleted: (_) => _onConfirm(),
              ),

              SizedBox(height: mq.size.height * 0.03),

              SizedBox(
                width: double.infinity,
                height: mq.size.height * 0.055,
                child: ElevatedButton(
                  onPressed: isVerifyLoading ? null : _onConfirm,
                  child: Text(LocaleKeys.confirm.tr()),
                ),
              ),

              SizedBox(height: mq.size.height * 0.02),

              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listenWhen: (previous, current) =>
                    previous.forgetPassword != current.forgetPassword,
                listener: (context, state) {
                  if (state.forgetPassword.isError) {
                    showAppSnackbar(
                      context,
                      state.forgetPassword.error ?? '',
                      backgroundColor: AppColors.error,
                    );
                  } else if (state.forgetPassword.isSuccess) {
                    showAppSnackbar(
                      context,
                      LocaleKeys.sendOTP.tr(),
                      backgroundColor: AppColors.success,
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    previous.forgetPassword.isLoading !=
                    current.forgetPassword.isLoading,
                builder: (context, state) {
                  return ResendCodeSection(
                    onResend: _onResend,
                    isLoading: state.forgetPassword.isLoading,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
