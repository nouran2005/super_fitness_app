import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
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

  @POST("${AppEndpoints.authPath}/${AppEndpoints.signInPath}")
  Future<HttpResponse<SigninResponse>> signIn(
    @Body() SigninPostModel loginRequest,
  );

  @POST(AppEndpoints.signupPath)
  Future<HttpResponse<SignupDto>> signUp(@Body() SignupRequest request);

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

  @GET("https://${AppEndpoints.mealsBaseUrl}${AppEndpoints.mealsCategoryPath}")
  Future<HttpResponse<MealsCategoriesDto>> getMealsCategories();

  @GET(
    "https://${AppEndpoints.mealsBaseUrl}${AppEndpoints.mealsByCategoryPath}",
  )
  Future<HttpResponse<MealsByCategoryDto>> getMealsByCategory(
    @Query('c') String category,
  );

  @GET("https://${AppEndpoints.mealsBaseUrl}${AppEndpoints.foodDetailsPath}")
  Future<HttpResponse<MealsDetailsDto>> getMealDetailsById(
    @Query('i') String mealId,
  );
}
