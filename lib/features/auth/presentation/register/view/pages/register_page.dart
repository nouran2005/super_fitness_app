import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/register_form.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final cubit = getIt<SignupCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider<SignupCubit>(
          create: (context) => cubit,
          child: Stack(
            children: [
              Image.asset(Assets.imagesAuthBackground2, fit: BoxFit.cover),
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
                    SizedBox(height: height * 0.01),
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
        ),
      ),
    );
  }
}
