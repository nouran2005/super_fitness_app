import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';

sealed class ForgetPasswordEvents {}

class ForgetPasswordProcessEvent extends ForgetPasswordEvents {
  final String email;

  ForgetPasswordProcessEvent(this.email);
}

class VerifyCodeProcessEvent extends ForgetPasswordEvents {
  final String code;

  VerifyCodeProcessEvent(this.code);
}

class ResetPasswordProcessEvent extends ForgetPasswordEvents {
  final ResetPasswordRequestModel request;

  ResetPasswordProcessEvent(this.request);
}
