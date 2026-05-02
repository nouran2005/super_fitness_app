import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/profile_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBlurryBackground(
        blurSigmaX: 1,
        blurSigmaY: 1,
        blurAlpha: 50,
        image: Assets.imagesHomeBackground,
        widget: const ProfileBody(),
      ),
    );
  }
}
