import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({
    super.key,
    required this.controller,
    required this.enabled,
    this.onCompleted,
  });

  static const int otpLength = 4;

  final PinInputController controller;
  final bool enabled;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      length: otpLength,
      pinController: controller,
      enabled: enabled,
      autoFocus: true,
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      onChanged: (_) {},
      theme: MaterialPinTheme(
        shape: MaterialPinShape.underlined,
        cellSize: const Size(52, 56),
        spacing: 16,
        borderWidth: 2,
        focusedBorderWidth: 2.5,
        borderColor: AppColors.primary,
        focusedBorderColor: AppColors.white,
        filledBorderColor: AppColors.primary,
        fillColor: Colors.transparent,
        focusedFillColor: Colors.transparent,
        filledFillColor: Colors.transparent,
        cursorColor: AppColors.white,
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        disabledColor: AppColors.disabled,
        entryAnimation: MaterialPinAnimation.fade,
      ),
    );
  }
}
