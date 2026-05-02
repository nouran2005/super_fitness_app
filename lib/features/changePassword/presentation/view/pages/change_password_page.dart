import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view/widgets/change_password_body.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_cubit.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ChangePasswordCubit>();
    return BlocProvider(
      create: (context) => cubit,
      child: AuthBlurryBackground(widget: ChangePasswordBody(cubit: cubit)),
    );
  }
}
