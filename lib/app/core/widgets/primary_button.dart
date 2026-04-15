import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isEnabled = true,
    this.height = 50,
    this.horizontalPadding = 0,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double height;
  final double horizontalPadding;

  bool get _canPress => isEnabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: _canPress ? onPressed : null,
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.white.withValues(alpha: 0.08);
              }
              return null;
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.lightGrey;
              }
              return AppColors.primary;
            }),
            foregroundColor: const WidgetStatePropertyAll(AppColors.white),
            minimumSize: WidgetStatePropertyAll(Size.fromHeight(height)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
            textStyle: WidgetStatePropertyAll(
              AppStyles.black18Medium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
