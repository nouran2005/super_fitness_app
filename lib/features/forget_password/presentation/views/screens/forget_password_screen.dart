import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/loading_indicator.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/forget_password_card.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/forget_password_lables.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (_) => getIt<ForgetPasswordCubit>(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesAuthBackground2),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesAppIcon,
                          height: mq.size.height * 0.07,
                          width: mq.size.width * 0.2,
                        ),
                        SizedBox(height: mq.size.height * 0.12),
                        const ForgetPasswordLables(),
                        SizedBox(height: mq.size.height * 0.05),
                        const ForgetPasswordCard(),
                      ],
                    ),
                  ),
                ),

                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.forgetPassword.isLoading !=
                      current.forgetPassword.isLoading,
                  builder: (context, state) {
                    if (!state.forgetPassword.isLoading) {
                      return const SizedBox.shrink();
                    }
                    return ColoredBox(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: const Center(child: LoadingIndicator()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
