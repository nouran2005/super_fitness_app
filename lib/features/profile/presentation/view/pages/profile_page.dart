import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/profile_body.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ProfileCubit>();
    return Scaffold(
      body: BlocProvider<ProfileCubit>(
        create: (context) => cubit..doIntent(ProfileDataEvent()),
        child: AuthBlurryBackground(
          blurSigmaX: 1,
          blurSigmaY: 1,
          blurAlpha: 50,
          image: Assets.imagesHomeBackground,
          widget: const ProfileBody(),
        ),
      ),
    );
  }
}
