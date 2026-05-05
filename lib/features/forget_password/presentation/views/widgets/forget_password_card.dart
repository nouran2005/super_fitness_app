import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/validation/app_validation.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/show_snak_bar.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_events.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ForgetPasswordCard extends StatefulWidget {
  const ForgetPasswordCard({super.key});

  @override
  State<ForgetPasswordCard> createState() => _ForgetPasswordCardState();
}

class _ForgetPasswordCardState extends State<ForgetPasswordCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendEmail() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgetPasswordCubit>().onEvent(
        ForgetPasswordProcessEvent(_emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
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
          context.go(
            RouteNames.verifyResetCode,
            extra: _emailController.text.trim(),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.forgetPassword != current.forgetPassword,
      builder: (context, state) {
        final isLoading = state.forgetPassword.isLoading;

        return GlassBlurContainer(
          padding: EdgeInsets.all(mq.size.width * 0.06),
          backgroundColor: AppColors.white.withValues(alpha: 0.05),
          blurSigma: 15,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.email.tr(),
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: mq.size.width * 0.04,
                        end: mq.size.width * 0.025,
                      ),
                      child: const Icon(Icons.email_outlined),
                    ),
                  ),
                  validator: Validators.emailValidator,
                ),
                SizedBox(height: mq.size.height * 0.026),
                SizedBox(
                  width: double.infinity,
                  height: mq.size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onSendEmail,
                    child: Text(LocaleKeys.sendOTP.tr()),
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
