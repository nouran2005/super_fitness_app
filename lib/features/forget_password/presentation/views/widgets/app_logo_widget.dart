import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Image.asset(
      Assets.imagesAppIcon,
      height: mq.size.height * 0.07,
      width: mq.size.width * 0.2,
    );
  }
}
