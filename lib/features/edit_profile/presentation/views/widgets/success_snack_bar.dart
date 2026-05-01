import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

SnackBar buildSuccessSnackBar(
  BuildContext context, {
  Duration duration = const Duration(seconds: 3),
}) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.check_circle_rounded, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            LocaleKeys.userDataUpdatedSuccessfully.tr(),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.success,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
    ),
    duration: duration,
  );
}
