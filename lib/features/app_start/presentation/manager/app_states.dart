import 'package:super_fitness_app/app/config/base_state/base_state.dart';

enum AppAuthStatus { onboarding, authenticated, unauthenticated }

class AppState {
  final Resource<AppAuthStatus> authResource;

  AppState({required this.authResource});

  factory AppState.initial() => AppState(authResource: Resource.initial());

  AppState copyWith({Resource<AppAuthStatus>? authResource}) {
    return AppState(authResource: authResource ?? this.authResource);
  }
}
