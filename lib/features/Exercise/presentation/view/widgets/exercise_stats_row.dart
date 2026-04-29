import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';

class ExerciseStatsRow extends StatelessWidget {
  const ExerciseStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02, // Reduced vertical padding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatChip('30 MIN', size),
          _buildStatChip('130 Cal', size, isCalorie: true),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, Size size, {bool isCalorie = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: AppStyles.font14White.copyWith(
          color: isCalorie ? AppColors.primary : AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.03, // Reduced from 0.035
        ),
      ),
    );
  }
}
