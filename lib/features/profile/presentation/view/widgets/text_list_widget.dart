import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';

class TextListWidget extends StatelessWidget {
  final String assetName;
  final String title;
  final bool hasSwitch;
  final VoidCallback? onTap;

  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const TextListWidget({
    super.key,
    required this.assetName,
    required this.title,
    this.hasSwitch = false,
    this.onTap,
    this.switchValue,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      dense: true,
      onTap: onTap,

      leading: SvgPicture.asset(assetName, color: AppColors.primary),
      title: Text(
        title,
        style: AppStyles.green14regular.copyWith(color: AppColors.white),
      ),

      trailing: hasSwitch
          ? Switch(
              value: switchValue ?? false,
              activeThumbColor: AppColors.primary,
              inactiveThumbColor: AppColors.white,
              onChanged: onSwitchChanged,
            )
          : const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
              size: 16,
            ),
    );
  }
}
