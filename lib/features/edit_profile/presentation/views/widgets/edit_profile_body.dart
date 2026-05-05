import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/custom_outlined_text_field.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_avatar.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_selection_tile.dart';
import 'package:super_fitness_app/app/config/validation/app_validation.dart';
import 'package:super_fitness_app/app/core/values/activity_levels.dart';
import 'package:super_fitness_app/app/core/values/fitness_goals.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class EditProfileBody extends StatelessWidget {
  final EditProfileState state;
  final Size size;
  final double horizontalPadding;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final Future<void> Function() openWeightSheet;
  final Future<void> Function() openGoalSheet;
  final Future<void> Function() openActivitySheet;

  const EditProfileBody({
    super.key,
    required this.state,
    required this.size,
    required this.horizontalPadding,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.openWeightSheet,
    required this.openGoalSheet,
    required this.openActivitySheet,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading =
        state.getLoggedUserData.isLoading && state.updatedUser == null;

    if (state.getLoggedUserData.isError && state.updatedUser == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.getLoggedUserData.error ??
                  LocaleKeys.somethingWentWrong.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<EditProfileCubit>().onEvent(
                GetLoggedUserDataProcessEvent(),
              ),
              child: Text(LocaleKeys.retry.tr()),
            ),
          ],
        ),
      );
    }

    final user = state.updatedUser;

    final originalUser = state.originalUser;
    final displayName = isLoading
        ? 'Placeholder Name'
        : '${originalUser?.firstName ?? ''} ${originalUser?.lastName ?? ''}'
              .trim();

    return Skeletonizer(
      enabled: isLoading,
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: size.height * 0.01,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        image: user?.photo ?? '',
                        isUploading: state.isPhotoUploading,
                        onPhotoPicked: (File photo) {
                          context.read<EditProfileCubit>().onEvent(
                            UploadProfileImageProcessEvent(photo),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.015),
                      Text(
                        displayName,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.032),

                CustomOutlinedTextField(
                  controller: firstNameController,
                  prefixIcon: Icons.person_outline,
                  hint: LocaleKeys.firstName.tr(),
                  validator: Validators.firstNameValidator,
                ),
                SizedBox(height: size.height * 0.016),
                CustomOutlinedTextField(
                  controller: lastNameController,
                  prefixIcon: Icons.person_outline,
                  hint: LocaleKeys.lastName.tr(),
                  validator: Validators.lastNameValidator,
                ),
                SizedBox(height: size.height * 0.016),
                CustomOutlinedTextField(
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  hint: LocaleKeys.email.tr(),
                  validator: Validators.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: size.height * 0.035),

                ProfileSelectionTile(
                  title: LocaleKeys.yourWeight.tr(),
                  value: '${user?.weight ?? '--'} ${LocaleKeys.kg.tr()}',
                  onTap: openWeightSheet,
                ),
                SizedBox(height: size.height * 0.018),
                ProfileSelectionTile(
                  title: LocaleKeys.yourGoal.tr(),
                  value: FitnessGoals.getDisplayGoal(user?.goal),
                  onTap: openGoalSheet,
                ),
                SizedBox(height: size.height * 0.018),
                ProfileSelectionTile(
                  title: LocaleKeys.yourActivityLevel.tr(),
                  value: ActivityLevels.getDisplayLevel(user?.activityLevel),
                  onTap: openActivitySheet,
                ),

                SizedBox(height: size.height * 0.035),

                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.055,
                  child: ElevatedButton(
                    onPressed: context.read<EditProfileCubit>().isSaveEnabled
                        ? () => context.read<EditProfileCubit>().onEvent(
                            SaveChangesProcessEvent(),
                          )
                        : null,

                    child: state.isSavingData
                        ? const SpinKitThreeBounce(
                            color: AppColors.primary,
                            size: 23.0,
                          )
                        : Text(LocaleKeys.saveChanges.tr()),
                  ),
                ),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
