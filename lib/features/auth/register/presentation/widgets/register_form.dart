import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/app/core/widgets/loading_indicator.dart';
import 'package:super_fitness_app/app/core/widgets/show_snak_bar.dart';
import 'package:super_fitness_app/features/auth/register/presentation/manager/register_cubit.dart';
import 'package:super_fitness_app/features/auth/register/presentation/manager/register_intent.dart';
import 'package:super_fitness_app/features/auth/register/presentation/manager/register_states.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widgets/register_form_fields.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final bloc = BlocProvider.of<RegisterCubit>(context);
    return GlassBlurContainer(
      backgroundColor: Colors.transparent,
      padding: EdgeInsetsGeometry.symmetric(
        vertical: height * 0.03,
        horizontal: width * 0.04,
      ),
      blurSigma: 34,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderColor: Colors.transparent,
      child: BlocListener<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state.registerResource.status == Status.loading) {
            LoadingIndicator();
          } else if (state.registerResource.status == Status.success) {
            showAppSnackbar(
              context,
              LocaleKeys.registerSuccessfully.tr(),
              backgroundColor: AppColors.primary,
            );
            context.push(
              '/gender',
              extra: {
                'firstName': firstNameController.text,
                'lastName': lastNameController.text,
                'email': emailController.text,
                'password': passwordController.text,
              },
            );
          } else if (state.registerResource.status == Status.error) {
            showAppSnackbar(
              context,
              state.registerResource.error.toString(),
              backgroundColor: AppColors.primary,
            );
          }
        },
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                LocaleKeys.register.tr(),
                style: AppStyles.black24SemiBold.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: height * 0.02),
              RegisterFormFields(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    bloc.doIntent(
                      RegisterFormIntent(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  }
                  FocusScope.of(context).unfocus();
                },
                child: Text(
                  LocaleKeys.register.tr(),
                  style: AppStyles.black24SemiBold.copyWith(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              GestureDetector(
                onTap: () {
                  context.push('/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: LocaleKeys.alreadyHaveAccount.tr(),
                        style: AppStyles.font14White.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: LocaleKeys.login.tr(),
                            style: AppStyles.font14White.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
