import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/loading_indicator.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ResendCodeSection extends StatelessWidget {
  const ResendCodeSection({
    super.key,
    required this.onResend,
    this.isLoading = false,
  });

  final VoidCallback onResend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.didntReceiveVerificationCode.tr(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        if (isLoading)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${LocaleKeys.resendCode.tr()} ...',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.primary),
              ),
              SizedBox(width: 4),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ],
          )
        else
          GestureDetector(
            onTap: onResend,
            child: Text(
              LocaleKeys.resendCode.tr(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}
