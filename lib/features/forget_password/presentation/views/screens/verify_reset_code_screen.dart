import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/loading_indicator.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/app_logo_widget.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/verify_reset_code_card.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/verify_reset_code_labels.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  const VerifyResetCodeScreen({super.key, required this.email});

  final String email;

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
                        const AppLogoWidget(),
                        SizedBox(height: mq.size.height * 0.08),
                        const VerifyResetCodeLabels(),
                        SizedBox(height: mq.size.height * 0.02),
                        VerifyResetCodeCard(email: email),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.verifyCode.isLoading !=
                      current.verifyCode.isLoading,
                  builder: (context, state) {
                    if (!state.verifyCode.isLoading) {
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
