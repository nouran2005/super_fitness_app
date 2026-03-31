// TODO: presentation SigninBody
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';

class SigninBody extends StatelessWidget {
  const SigninBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 46),
            SvgPicture.asset(Assets.imagesLogo),
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
            SizedBox(height: 12),
            GlassBlurContainer(
              borderRadius: BorderRadius.circular(50),
              borderColor: Colors.transparent,
              blurSigma: 20,
              // shadowColor: Colors.red,
              backgroundColor: Color(0xff2424241A).withAlpha(25),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
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
