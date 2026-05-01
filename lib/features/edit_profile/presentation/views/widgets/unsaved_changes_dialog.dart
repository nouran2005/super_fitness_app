import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class UnsavedChangesDialog extends StatelessWidget {
  final VoidCallback onDiscard;

  const UnsavedChangesDialog({super.key, required this.onDiscard});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      backgroundColor: AppColors.darkGrey,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(w * 0.06),
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final isSaving = state.isSavingData;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSaving)
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: w * 0.09,
                      height: w * 0.09,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.all(w * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: w * 0.09,
                    ),
                  ),
                SizedBox(height: h * 0.025),

                Text(
                  isSaving ? "" : LocaleKeys.unsavedChanges.tr(),
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: h * 0.015),

                if (isSaving)
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: AppColors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  Text(
                    LocaleKeys.unsavedChangesMessage.tr(),
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: AppColors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: h * 0.04),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: isSaving ? null : onDiscard,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: h * 0.018),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(w * 0.03),
                            side: const BorderSide(color: AppColors.grey),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.discard.tr(),
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                fontSize: w * 0.038,
                                fontWeight: FontWeight.w600,
                                color: isSaving
                                    ? AppColors.grey
                                    : AppColors.white,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.04),
                    Expanded(
                      child: BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, state) {
                          final canSave =
                              state.isFormValid && !state.isSavingData;
                          return TextButton(
                            onPressed: isSaving
                                ? null
                                : (canSave
                                      ? () {
                                          Navigator.of(context).pop();
                                          context
                                              .read<EditProfileCubit>()
                                              .onEvent(
                                                SaveChangesProcessEvent(),
                                              );
                                        }
                                      : null),
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: h * 0.018,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(w * 0.03),
                                side: const BorderSide(color: AppColors.grey),
                              ),
                            ),
                            child: isSaving
                                ? SizedBox(
                                    width: w * 0.05,
                                    height: w * 0.05,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    LocaleKeys.saveChanges.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: AppColors.white,
                                          fontSize: w * 0.038,
                                        ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
