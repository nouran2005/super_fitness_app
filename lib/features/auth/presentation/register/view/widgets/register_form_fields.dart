import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/config/validation/app_validation.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Column(
      children: [
        CustomTextFormField(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          keyboardType: TextInputType.text,
          errorStyle: AppStyles.subtitle.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: AppStyles.subtitle.copyWith(
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(Icons.person_outline, color: AppColors.white70),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: firstNameController,
          labelText: LocaleKeys.firstName.tr(),
          validator: (val) => Validators.firstNameValidator(val),
        ),
        SizedBox(height: height * 0.02),
        CustomTextFormField(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          keyboardType: TextInputType.text,
          errorStyle: AppStyles.subtitle.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: AppStyles.subtitle.copyWith(
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(Icons.person_outline, color: AppColors.white70),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: lastNameController,
          labelText: LocaleKeys.lastName.tr(),
          validator: (val) => Validators.lastNameValidator(val),
        ),
        SizedBox(height: height * 0.02),
        CustomTextFormField(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          keyboardType: TextInputType.emailAddress,
          errorStyle: AppStyles.subtitle.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: AppStyles.subtitle.copyWith(
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.white70,
            size: 20,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: emailController,
          labelText: LocaleKeys.email.tr(),
          validator: (val) => Validators.emailValidator(val),
        ),
        SizedBox(height: height * 0.02),
        CustomTextFormField(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          keyboardType: TextInputType.visiblePassword,
          errorStyle: AppStyles.subtitle.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: AppStyles.subtitle.copyWith(
            color: AppColors.lightGrey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: AppColors.white70,
            size: 20,
          ),
          iconColor: AppColors.white70,
          obscureText: true,
          showPasswordToggle: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: passwordController,
          labelText: LocaleKeys.password.tr(),
          validator: (val) => Validators.passwordValidator(val),
        ),
      ],
    );
  }
}
