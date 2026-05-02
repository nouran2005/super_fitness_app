import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';

abstract class ChangePasswordRepository {
  Future<ApiResult<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  );
}
