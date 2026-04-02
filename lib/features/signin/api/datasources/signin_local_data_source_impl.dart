// TODO: api SigninLocalDataSourceImpl

import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_local_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_remote_data_source_contract.dart';

@Injectable(as: SigninLocalDataSourceContract)
class SigninLocalDataSourceImpl implements SigninLocalDataSourceContract {
  final AuthStorage authStorage;

  SigninLocalDataSourceImpl({required this.authStorage});
  @override
  Future<void> cachedToken(String token) async {
    authStorage.saveToken(token);
  }
}
