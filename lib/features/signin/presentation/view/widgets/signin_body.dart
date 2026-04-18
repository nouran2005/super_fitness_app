// TODO: presentation SigninBody
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/utils/validations.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_text_link.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class SigninBody extends StatefulWidget {
  final SigninCubit cubit;
  const SigninBody({super.key, required this.cubit});

  @override
  State<SigninBody> createState() => _SigninBodyState();
}

class _SigninBodyState extends State<SigninBody> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 46),
              Image.asset(Assets.appIcon, height: 120),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.heyThere.tr(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      LocaleKeys.welcomeBack.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GlassBlurContainer(
                borderRadius: BorderRadius.circular(50),
                borderColor: Colors.transparent,
                blurSigma: 20,
                // shadowColor: Colors.red,
                backgroundColor: const Color(0x2424241A).withAlpha(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      LocaleKeys.login.tr(),
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: widget.cubit.emailController,
                      validator: Validations.validateEmail,
                      hintText: LocaleKeys.email.tr(),
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: widget.cubit.passwordController,

                      validator: Validations.validatePassword,

                      hintText: LocaleKeys.password.tr(),
                      obscureText: true,

                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AuthTextLink(
                          fontSize: 14,
                          // fontWeight: FontWeight.w800,
                          text: '${LocaleKeys.forgotPassword.tr()} ?',
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.centerLeft,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: LocaleKeys.signIn.tr(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.cubit.signIn();
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.dontHaveAccount.tr()),
                        AuthTextLink(
                          fontSize: 14,
                          // fontWeight: FontWeight.w800,
                          text: LocaleKeys.registerNow.tr(),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            context.go(RouteNames.signup);
                          },
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
