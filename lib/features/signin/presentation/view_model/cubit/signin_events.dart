// TODO: presentation SigninEvents

import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';

sealed class SigninEvents {}

class SigninEvent extends SigninEvents {
  final SigninEntity loginEntity;

  SigninEvent({required this.loginEntity});
}
