import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/repos/forget_password_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ForgetPasswordUseCase(this._forgetPasswordRepo);

  Future<ApiResult<ForgetPasswordEntity>> call(String email) {
    return _forgetPasswordRepo.forgetPassword(email);
  }
}
