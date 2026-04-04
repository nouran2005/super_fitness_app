import 'package:super_fitness_app/app/config/base_state/base_state.dart';

class RegisterStates {
  final Resource<dynamic> registerResource;

  RegisterStates({Resource<dynamic>? registerResource})
    : registerResource = registerResource ?? Resource.initial();

  RegisterStates copywith({Resource<dynamic>? registerResource}) {
    return RegisterStates(
      registerResource: registerResource ?? this.registerResource,
    );
  }
}
