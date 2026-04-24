import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class ContainerTitle extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  final EdgeInsetsGeometry? padding;

  const ContainerTitle({
    super.key,
    required this.text,
    required this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: screenWidth * 0.025,
            vertical: screenHeight * 0.006,
          ),
      decoration: BoxDecoration(
        color: AppColors.darkGrey.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(screenWidth * 0.055),
      ),
      child: Center(
        child: Text(text, style: textStyle, textAlign: TextAlign.center),
      ),
    );
  }
}
