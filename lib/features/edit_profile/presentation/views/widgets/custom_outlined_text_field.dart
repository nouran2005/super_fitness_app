import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class CustomOutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomOutlinedTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(
            start: mq * 0.04,
            end: mq * 0.025,
          ),
          child: Icon(prefixIcon),
        ),
      ),
    );
  }
}
