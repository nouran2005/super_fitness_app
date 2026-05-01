import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/app/core/widgets/show_app_dialog.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_state.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/divider.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/logout_dialog.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/text_list_widget.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    return BlocProvider<LogoutCubit>(
      create: (context) => getIt<LogoutCubit>(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  LocaleKeys.profile.tr(),
                  style: AppStyles.black24SemiBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: height * 0.03),
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                    (state.profileData.data?.user?.photo).toString(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ("${state.profileData.data?.user?.firstName} ${state.profileData.data?.user?.lastName}"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),
                GlassBlurContainer(
                  padding: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(20),
                  borderColor: Colors.transparent,
                  blurSigma: 20,
                  backgroundColor: AppColors.grey.withOpacity(0.2),

                  child: Column(
                    children: [
                      TextListWidget(
                        assetName: Assets.imagesProfile,
                        title: LocaleKeys.editProfile.tr(),
                        onTap: () {},
                      ),
                      DividerWidget(),
                      TextListWidget(
                        assetName: Assets.imagesChangePassword,
                        title: LocaleKeys.changePassword.tr(),
                        onTap: () {},
                      ),
                      DividerWidget(),
                      BlocConsumer<ProfileCubit, ProfileState>(
                        listener: (context, state) {
                          context.setLocale(Locale(state.languageCode));
                        },
                        builder: (context, state) {
                          final cubit = BlocProvider.of<ProfileCubit>(context);
                          return TextListWidget(
                            assetName: Assets.imagesLanguage,
                            title:
                                "${LocaleKeys.selectLanguage.tr()} (${state.languageCode == 'en' ? LocaleKeys.english.tr() : LocaleKeys.arabic.tr()})",
                            hasSwitch: true,
                            switchValue: state.languageCode == 'en',
                            onSwitchChanged: (value) {
                              cubit.doIntent(ChangeLanguageEvent());
                            },
                          );
                        },
                      ),
                      DividerWidget(),
                      TextListWidget(
                        assetName: Assets.imagesSecurity,
                        title: LocaleKeys.security.tr(),
                        onTap: () {
                          context.push(RouteNames.securityPage);
                        },
                      ),
                      DividerWidget(),
                      TextListWidget(
                        assetName: Assets.imagesPrivacy,
                        title: LocaleKeys.privacyPolicy.tr(),
                        onTap: () {
                          context.push(RouteNames.privacyPage);
                        },
                      ),
                      DividerWidget(),
                      TextListWidget(
                        assetName: Assets.imagesHelp,
                        title: LocaleKeys.help.tr(),
                        onTap: () {
                          context.push(RouteNames.helpPage);
                        },
                      ),
                      DividerWidget(),
                      BlocConsumer<LogoutCubit, LogoutStates>(
                        listener: (context, state) async {
                          if (state.logoutResource.isSuccess) {
                            context.go(RouteNames.login);
                          }

                          if (state.logoutResource.isError) {
                            showAppDialog(
                              context,
                              message: state.logoutResource.error ?? 'Error',
                            );
                          }
                        },
                        builder: (context, state) {
                          return TextListWidget(
                            assetName: Assets.imagesLogout,
                            title: LocaleKeys.logout.tr(),
                            onTap: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const LogoutDialog(),
                              );

                              if (confirm == true) {
                                BlocProvider.of<LogoutCubit>(
                                  context,
                                ).doIntent(PerformLogout());
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
