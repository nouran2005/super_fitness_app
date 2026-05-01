import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/values/api_constants.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';

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
  @GET(AppEndpoints.randomMusclesPath)
  Future<HttpResponse<RecommendationToDay>> getRandomMuscles(
    @Header(ApiConstants.acceptLanguage) String language,
  );

  @GET(AppEndpoints.getAllMusclesGroup)
  Future<HttpResponse<AllMusclesGroupResponse>> getAllMusclesGroup({
    @Header(ApiConstants.acceptLanguage) required String language,
  });

  @GET(AppEndpoints.getAllMusclesByMuscleGroup)
  Future<HttpResponse<AllMusclesByMuscleGroupResponse>>
  getAllMusclesByMuscleGroup({
    @Header(ApiConstants.acceptLanguage) required String language,
    @Path("muscleGroupId") required String muscleGroupId,
  });

  @GET(AppEndpoints.musclesRandomPath)
  Future<HttpResponse<MusclesRandomResponseModel>> getRandom20Muscles();

  @GET(AppEndpoints.levelsPath)
  Future<HttpResponse<LevelsResponseModel>> getLevels();

  @GET(AppEndpoints.exercisesByMuscleDifficulty)
  Future<HttpResponse<ExercisesByMuscleDifficultyResponseModel>>
  getExercisesByMuscleDifficulty({
    @Query(ApiConstants.primeMoverMuscleId) required String primeMoverMuscleId,
    @Query(ApiConstants.difficultyLevelId) required String difficultyLevelId,
  });

  @GET(AppEndpoints.exercisesPath)
  Future<HttpResponse<ExerciseResponse>> getExercises({
    @Header(ApiConstants.acceptLanguage) required String language,
  });

  @GET(AppEndpoints.exercisesRandomPath)
  Future<HttpResponse<ExerciseResponse>> getExercisesRandom({
    @Header(ApiConstants.acceptLanguage) required String language,
    @Query("targetMuscleGroupId") required String muscleGroupId,
    @Query("difficultyLevelId") required String difficultyId,
    @Query("limit") int limit = 160,
  });

  @GET(AppEndpoints.profilePath)
  Future<HttpResponse<ProfileDataDto>> getProfileData(
    @Header(ApiConstants.authorization) String token,
  );

  @GET(AppEndpoints.logoutPath)
  Future<HttpResponse<LogoutResponse>> logout({
    @Header("Authorization") required String token,
  });
  @GET(AppEndpoints.getLoggedUserDataPath)
  Future<HttpResponse<LoggedUserDataResponseModel>> getLoggedUserData();

  @PUT(AppEndpoints.editProfilePath)
  Future<HttpResponse<LoggedUserDataResponseModel>> editProfile(
    @Body() EditProfileRequestModel requestModel,
  );

  @PUT(AppEndpoints.uploadProfileImagePath)
  @MultiPart()
  Future<HttpResponse<String>> uploadImage(
    @Part(name: ApiConstants.photo) File photo,
  );
}
