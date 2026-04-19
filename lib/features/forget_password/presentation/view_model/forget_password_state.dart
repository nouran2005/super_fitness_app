import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';

class ForgetPasswordState {
  final Resource<ForgetPasswordEntity> forgetPassword;
  final Resource<VerifyCodeEntity> verifyCode;
  final Resource<ResetPasswordEntity> resetPassword;

  ForgetPasswordState({
    required this.forgetPassword,
    required this.verifyCode,
    required this.resetPassword,
  });

  ForgetPasswordState copyWith({
    Resource<ForgetPasswordEntity>? forgetPassword,
    Resource<VerifyCodeEntity>? verifyCode,
    Resource<ResetPasswordEntity>? resetPassword,
  }) {
    return ForgetPasswordState(
      forgetPassword: forgetPassword ?? this.forgetPassword,
      verifyCode: verifyCode ?? this.verifyCode,
      resetPassword: resetPassword ?? this.resetPassword,
    );
  }
}
