import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/repos/forget_password_repo.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ResetPasswordUseCase(this._forgetPasswordRepo);

  Future<ApiResult<ResetPasswordEntity>> call(
    ResetPasswordRequestModel request,
  ) {
    return _forgetPasswordRepo.resetPassword(request);
  }
}
