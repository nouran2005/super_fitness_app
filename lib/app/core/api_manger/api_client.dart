import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(AppEndpoints.forgotPasswordPath)
  Future<HttpResponse<ForgotPasswordResponseModel>> forgotPassword(
    @Body() ForgetPasswordRequestModel requestModel,
  );

  @POST(AppEndpoints.verifyResetCodePath)
  Future<HttpResponse<VerifyCodeResponseModel>> verifyOtp(
    @Body() VerifyCodeRequestModel requestModel,
  );

  @POST(AppEndpoints.resetPasswordPath)
  Future<HttpResponse<ResetPasswordResponseModel>> resetPassword(
    @Body() ResetPasswordRequestModel requestModel,
  );
}
