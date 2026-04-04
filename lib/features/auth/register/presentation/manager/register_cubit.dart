import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/register/presentation/manager/register_intent.dart';
import 'package:super_fitness_app/features/auth/register/presentation/manager/register_states.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  // final RegisterUsecase _registerUseCase;
  // RegisterCubit(this._registerUseCase) : super(RegisterStates());
  RegisterCubit() : super(RegisterStates());

  void doIntent(RegisterIntent event) async {
    switch (event) {
      case RegisterFormIntent():
        _signup(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        );
    }
  }

  Future<void> _signup({
    required String lastName,
    required String email,
    required String firstName,
    required String password,
  }) async {
    // final ApiResult<dynamic> response = await _registerUseCase.call(
    //   firstName: firstName,
    //   lastName: lastName,
    //   email: email,
    //   password: password,
    // );

    // switch (response) {
    //   case SuccessApiResult<RegisterModel>():
    //     emit(state.copywith(registerResource: Resource.success(response.data)));

    //   case ErrorApiResult<RegisterModel>():
    //     emit(
    //       state.copywith(
    //         registerResource: Resource.error(response.error.toString()),
    //       ),
    //     );
    // }
  }
}
