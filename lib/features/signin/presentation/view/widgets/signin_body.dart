// TODO: presentation SigninBody
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_text_link.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class SigninBody extends StatelessWidget {
  const SigninBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 46),
            // SvgPicture.asset(Assets.imagesLogo),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Hey There".tr(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "WELCOME BACK".tr(),
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
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    hintText: LocaleKeys.email.tr(),
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
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
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
