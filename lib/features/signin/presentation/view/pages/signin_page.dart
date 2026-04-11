import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/signin/presentation/view/widgets/signin_body.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<SigninCubit>();
    return BlocProvider(
      create: (context) => cubit,
      child: AuthBlurryBackground(widget: SigninBody(cubit: cubit)),
    );
  }
}
