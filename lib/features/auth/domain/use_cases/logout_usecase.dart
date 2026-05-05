import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUsecase {
  final AuthRepository _authRepo;
  LogoutUsecase(this._authRepo);

  Future<ApiResult<LogoutResponse>> call({required String token}) async {
    return await _authRepo.logout(token: token);
  }
}
