import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';

class AuthBlurryBackground extends StatelessWidget {
  final String? image;
  final Widget widget;
  final double blurSigmaX;
  final double blurSigmaY;
  final int blurAlpha;
  const AuthBlurryBackground({
    super.key,
    this.image,
    required this.widget,
    this.blurSigmaX = 10,
    this.blurSigmaY = 10,
    this.blurAlpha = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image ?? Assets.imagesAuthBackground2, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
            child: Container(color: Colors.black.withAlpha(blurAlpha)),
          ),
          widget,
        ],
      ),
    );
  }
}
