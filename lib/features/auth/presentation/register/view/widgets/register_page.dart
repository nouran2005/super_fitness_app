import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/register_form.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.03),
                Image.asset(Assets.imagesAppIcon, height: height * 0.09),
                SizedBox(height: height * 0.03),
                Text(
                  LocaleKeys.heyThere.tr(),
                  style: AppStyles.black18Medium.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  LocaleKeys.createAnAccount.tr(),
                  style: AppStyles.black14bold.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: height * 0.02),
                RegisterForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
