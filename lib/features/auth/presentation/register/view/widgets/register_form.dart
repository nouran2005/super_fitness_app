import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/register_form_fields.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final cubit = BlocProvider.of<SignupCubit>(context);
    return GlassBlurContainer(
      backgroundColor: Colors.transparent,
      padding: EdgeInsetsGeometry.symmetric(
        vertical: height * 0.03,
        horizontal: width * 0.04,
      ),
      blurSigma: 34,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderColor: Colors.transparent,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              LocaleKeys.register.tr(),
              style: AppStyles.black24SemiBold.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: height * 0.02),
            RegisterFormFields(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              emailController: emailController,
              passwordController: passwordController,
            ),
            SizedBox(height: height * 0.03),
            SizedBox(
              width: double.infinity,
              height: height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.doIntent(
                      SetBasicInfo(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                    context.push(RouteNames.completeSignup, extra: cubit);
                  }
                  FocusScope.of(context).unfocus();
                },
                child: Text(
                  LocaleKeys.register.tr(),
                  style: AppStyles.black24SemiBold.copyWith(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                context.go(RouteNames.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: LocaleKeys.alreadyHaveAccount.tr(),
                      style: AppStyles.font14White.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: LocaleKeys.login.tr(),
                          style: AppStyles.font14White
                              .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              )
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
