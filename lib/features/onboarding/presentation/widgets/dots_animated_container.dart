import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class DotsAnimatedContainer extends StatelessWidget {
  const DotsAnimatedContainer({
    super.key,
    required this.index,
    required this.currentIndex,
  });
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    bool isActive = index == currentIndex;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
