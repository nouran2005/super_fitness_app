import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/utils/validations.dart';
import 'package:super_fitness_app/app/core/widgets/toast/custom_toast.dart';
import 'package:toastification/toastification.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_text_link.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';

import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_intent.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_state.dart';

import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';

class ChangePasswordBody extends StatefulWidget {
  final ChangePasswordCubit cubit;
  const ChangePasswordBody({super.key, required this.cubit});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return SafeArea(
      child: BlocListener<ChangePasswordCubit, ChangePasswordStates>(
        listenWhen: (previous, current) =>
            previous.changePasswordResource != current.changePasswordResource,
        listener: (context, state) {
          if (state.changePasswordResource.isSuccess) {
            showToast(
              title: LocaleKeys.success.tr(),
              description: state.changePasswordResource.data?.message ??
                  LocaleKeys.passwordResetSuccess.tr(),
              type: ToastificationType.success,
            );
            context.go(RouteNames.signIn);
          } else if (state.changePasswordResource.isError) {

            showToast(
              title: LocaleKeys.error.tr(),
              description: state.changePasswordResource.error ?? "Error",
              type: ToastificationType.error,
            );
          }
        },

        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: h * 0.05),
                Image.asset(Assets.appIcon, height: h * 0.10),
                SizedBox(height: h * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.makeSureIts8CharactersOrMore.tr(),
                        style: TextStyle(
                          fontSize: w * 0.04,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        LocaleKeys.createNewPassword.tr(),
                        style: TextStyle(
                          fontSize: w * 0.06,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),
                GlassBlurContainer(
                  borderRadius: BorderRadius.circular(w * 0.12),
                  borderColor: Colors.transparent,
                  blurSigma: 20,
                  backgroundColor: const Color(0x2424241A).withAlpha(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                        controller: widget.cubit.oldPasswordController,
                        validator: Validations.validatePassword,
                        hintText: LocaleKeys.oldPassword.tr(),
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),

                      ),
                      SizedBox(height: h * 0.02),
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                        controller: widget.cubit.newPasswordController,
                        validator: Validations.validatePassword,
                        hintText: LocaleKeys.newPassword.tr(),
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),

                      ),
                      SizedBox(height: h * 0.02),
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                        controller: widget.cubit.confirmPasswordController,
                        validator: (value) =>
                            Validations.validatePasswordVerification(
                          value,
                          widget.cubit.newPasswordController.text,
                        ),
                        hintText: LocaleKeys.confirmPassword.tr(),
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                      ),
                      SizedBox(height: h * 0.015),
                       
                      SizedBox(height: h * 0.04),
                      BlocBuilder<ChangePasswordCubit, ChangePasswordStates>(
                        builder: (context, state) {
                          return PrimaryButton(
                            text: LocaleKeys.done.tr(),

                            onPressed: state.changePasswordResource.isLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      widget.cubit.doIntent(
                                        ChangePasswordSubmitIntent(),
                                      );
                                    }
                                  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
