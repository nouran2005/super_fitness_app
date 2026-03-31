import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/signin/presentation/view/widgets/signin_body.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthBlurryBackground(widget: SigninBody());
  }
}
