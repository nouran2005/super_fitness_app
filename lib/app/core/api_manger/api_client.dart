import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("${AppEndpoints.authPath}/${AppEndpoints.signInPath}")
  Future<HttpResponse<SigninResponse>> signIn(
    @Body() SigninPostModel loginRequest,
  );

  @POST(AppEndpoints.signupPath)
  Future<HttpResponse<SignupDto>> signUp(@Body() SignupRequest request);
}
