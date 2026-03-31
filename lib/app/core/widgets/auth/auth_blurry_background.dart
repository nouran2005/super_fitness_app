import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';

class AuthBlurryBackground extends StatelessWidget {
  final String? image;
  final Widget widget;
  const AuthBlurryBackground({super.key, this.image, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,

        children: [
          Image.asset(image ?? Assets.imagesAuthBackground2, fit: BoxFit.cover),
          widget,
        ],
      ),
    );
  }
}
