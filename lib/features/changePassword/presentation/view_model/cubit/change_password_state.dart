import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';

class ChangePasswordStates {
  final Resource<ChangePasswordResponse> changePasswordResource;

  ChangePasswordStates({required this.changePasswordResource});

  ChangePasswordStates copyWith({
    Resource<ChangePasswordResponse>? changePasswordResource,
  }) {
    return ChangePasswordStates(
      changePasswordResource:
          changePasswordResource ?? this.changePasswordResource,
    );
  }
}
