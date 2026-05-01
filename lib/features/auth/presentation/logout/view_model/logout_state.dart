import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';

class LogoutStates {
  final Resource<LogoutResponse> logoutResource;

  LogoutStates({Resource<LogoutResponse>? logoutResource})
    : logoutResource = logoutResource ?? Resource.initial();

  LogoutStates copyWith({Resource<LogoutResponse>? logoutResource}) {
    return LogoutStates(logoutResource: logoutResource ?? this.logoutResource);
  }
}
