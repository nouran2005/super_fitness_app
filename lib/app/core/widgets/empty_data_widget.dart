import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyDataWidget({
    super.key,
    this.message = 'No data found',
    this.icon = Icons.folder_open_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.grey.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: size.width * 0.2,
              color: AppColors.primary.withAlpha(170),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w600,
              color: AppColors.white.withAlpha(200),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Try adjusting your filters or check back later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.035,
                color: AppColors.disabled,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
