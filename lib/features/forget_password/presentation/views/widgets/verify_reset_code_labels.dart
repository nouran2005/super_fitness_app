import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class VerifyResetCodeLabels extends StatelessWidget {
  const VerifyResetCodeLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.otpCode.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.enterYourOtpCheckYourEmail.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
