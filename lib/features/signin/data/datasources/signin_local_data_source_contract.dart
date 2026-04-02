import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';

abstract class SigninLocalDataSourceContract {
  Future<void> cachedToken(String token);
}
