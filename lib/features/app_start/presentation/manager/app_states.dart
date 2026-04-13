import 'package:super_fitness_app/app/config/base_state/base_state.dart';

class AppState {
  final Resource<bool> authResource;

  AppState({required this.authResource});

  factory AppState.initial() => AppState(authResource: Resource.initial());

  AppState copyWith({Resource<bool>? authResource}) {
    return AppState(authResource: authResource ?? this.authResource);
  }
}
