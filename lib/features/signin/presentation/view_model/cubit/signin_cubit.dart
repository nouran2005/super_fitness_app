// TODO: presentation SigninCubit

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_events.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_states.dart';

@injectable
class SigninCubit extends Cubit<SigninStates> {
  SigninCubit({required this.signinUseCase})
    : super(SigninStates(loginResource: Resource.initial()));
  final SigninUseCase signinUseCase;
  void doIntent(SigninEvents event) {
    switch (event) {
      case SigninEvent():
        signIn();
    }
  }

  Future<void> signIn() async {}
}
