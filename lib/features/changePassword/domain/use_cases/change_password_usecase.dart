import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/changePassword/domain/repositories/change_password_repository.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<ApiResult<ChangePasswordResponse>> execute(
    ChangePasswordRequest request,
  ) {
    return _repository.changePassword(request);
  }
}
