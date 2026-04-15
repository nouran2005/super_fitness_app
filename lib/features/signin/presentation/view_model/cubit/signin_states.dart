// ignore_for_file: public_member_api_docs, sort_constructors_first
// TODO: presentation SigninStates

import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';

class SigninStates {
  final Resource<SigninEntity> loginResource;

  SigninStates({required this.loginResource});

  SigninStates copyWith({Resource<SigninEntity>? loginResource}) {
    return SigninStates(loginResource: loginResource ?? this.loginResource);
  }
}
