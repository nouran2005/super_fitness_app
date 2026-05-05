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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: h * 0.01),
              Image.asset(Assets.appIcon, height: h * 0.10),
              SizedBox(height: h * 0.08),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.heyThere.tr(),
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      LocaleKeys.welcomeBack.tr(),
                      style: TextStyle(
                        fontSize: w * 0.05,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              GlassBlurContainer(
                borderRadius: BorderRadius.circular(w * 0.12),
                borderColor: Colors.transparent,
                blurSigma: 20,
                backgroundColor: const Color(0x2424241A).withAlpha(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.login.tr(),
                      style: TextStyle(
                        fontSize: w * 0.06,
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    CustomTextFormField(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 18,
                      ),
                      controller: widget.cubit.emailController,
                      validator: Validations.validateEmail,
                      hintText: LocaleKeys.email.tr(),
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                    ),
                    SizedBox(height: h * 0.02),
                    CustomTextFormField(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 18,
                      ),
                      controller: widget.cubit.passwordController,

                      validator: Validations.validatePassword,

                      hintText: LocaleKeys.password.tr(),
                      obscureText: true,

                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                    ),
                    SizedBox(height: h * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AuthTextLink(
                          fontSize: w * 0.035,
                          text: LocaleKeys.forgotPassword.tr(),
                          padding: EdgeInsets.symmetric(horizontal: w * 0.015),
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            context.push(RouteNames.forgetPassword);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.03),
                    PrimaryButton(
                      text: LocaleKeys.signIn.tr(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.cubit.signIn();
                        }
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(height: h * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.dontHaveAccount.tr()),
                        AuthTextLink(
                          fontSize: w * 0.035,
                          text: LocaleKeys.registerNow.tr(),
                          padding: EdgeInsets.symmetric(horizontal: w * 0.015),
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            context.push(RouteNames.signup);
                          },
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.01),
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
