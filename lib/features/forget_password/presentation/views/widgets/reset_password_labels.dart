import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ResetPasswordLabels extends StatelessWidget {
  const ResetPasswordLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.makeSureIts8CharactersOrMore.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.createNewPassword.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
