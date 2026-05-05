import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/repos/forget_password_repo.dart';

@injectable
class VerifyCodeUseCase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  VerifyCodeUseCase(this._forgetPasswordRepo);

  Future<ApiResult<VerifyCodeEntity>> call(String code) {
    return _forgetPasswordRepo.verifyCode(code);
  }
}
