// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/app_start/presentation/manager/app_cubit.dart'
    as _i858;
import '../../../features/auth/api/datasources/auth_remote_data_source_impl.dart'
    as _i339;
import '../../../features/auth/data/datasources/auth_remote_data_source_contract.dart'
    as _i435;
import '../../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i365;
import '../../../features/auth/domain/repositories/auth_repository.dart'
    as _i234;
import '../../../features/auth/domain/use_cases/signup_use_case.dart' as _i128;
import '../../../features/auth/presentation/register/view_model/signup_cubit.dart'
    as _i22;
import '../../../features/edit_profile/api/datasources_impl/edit_profile_remote_datasource_impl.dart'
    as _i474;
import '../../../features/edit_profile/data/datasources/edit_profile_remote_datasource.dart'
    as _i368;
import '../../../features/edit_profile/data/repos/edit_profile_repo_impl.dart'
    as _i202;
import '../../../features/edit_profile/domain/repos/edit_profile_repo.dart'
    as _i485;
import '../../../features/edit_profile/domain/usecases/edit_profile_usecase.dart'
    as _i276;
import '../../../features/edit_profile/domain/usecases/get_logged_user_data_usecase.dart'
    as _i729;
import '../../../features/edit_profile/domain/usecases/upload_profile_image_usecase.dart'
    as _i489;
import '../../../features/Exercise/api/dataScources/exercise_remote_data_source_impl.dart'
    as _i524;
import '../../../features/Exercise/data/dataScources/exercise_remote_data_source.dart'
    as _i391;
import '../../../features/Exercise/data/repo/exercise_repo_impl.dart' as _i690;
import '../../../features/Exercise/domain/repo/exercise_repo.dart' as _i983;
import '../../../features/Exercise/domain/usecase/get_exercises_random_use_case.dart'
    as _i94;
import '../../../features/Exercise/domain/usecase/get_exercises_use_case.dart'
    as _i832;
import '../../../features/Exercise/presentation/manger/exercise_cubit.dart'
    as _i572;
import '../../../features/forget_password/api/datasources_impl/forget_password_remote_datasource_impl.dart'
    as _i278;
import '../../../features/forget_password/data/datasources/forget_password_remote_datasource.dart'
    as _i466;
import '../../../features/forget_password/data/repos/forget_password_repo_impl.dart'
    as _i132;
import '../../../features/forget_password/domain/repos/forget_password_repo.dart'
    as _i409;
import '../../../features/forget_password/domain/usecases/forget_password_usecase.dart'
    as _i747;
import '../../../features/forget_password/domain/usecases/reset_password_usecase.dart'
    as _i347;
import '../../../features/forget_password/domain/usecases/verify_code_usecase.dart'
    as _i225;
import '../../../features/forget_password/presentation/view_model/forget_password_cubit.dart'
    as _i488;
import '../../../features/home/api/home_remote_data_source_imp.dart' as _i874;
import '../../../features/home/data/dataScources/home_remote_data_source.dart'
    as _i599;
import '../../../features/home/data/repo/home_repo_impl.dart' as _i758;
import '../../../features/home/domain/repo/home_repo.dart' as _i242;
import '../../../features/home/domain/usecase/get_random_muscles_usecase.dart'
    as _i784;
import '../../../features/home/presentation/manger/Rc_to_day_cubit.dart'
    as _i956;
import '../../../features/meals/api/datasources/meals_remote_data_source_impl.dart'
    as _i77;
import '../../../features/meals/data/datasources/meals_remote_data_source_contract.dart'
    as _i158;
import '../../../features/meals/data/repositories/meals_repository_impl.dart'
    as _i60;
import '../../../features/meals/domain/repositories/meals_repository.dart'
    as _i936;
import '../../../features/meals/domain/use_cases/get_meal_details_by_id_usecase.dart'
    as _i1023;
import '../../../features/meals/domain/use_cases/get_meals_by_category_usecase.dart'
    as _i447;
import '../../../features/meals/domain/use_cases/get_meals_categories_usecase.dart'
    as _i601;
import '../../../features/meals/presentation/view_model/cubit/meals_cubit.dart'
    as _i316;
import '../../../features/popular_training/api/datasources_impl/popular_training_remote_datasource_impl.dart'
    as _i723;
import '../../../features/popular_training/data/datasources/popular_training_remote_datasource.dart'
    as _i869;
import '../../../features/popular_training/data/repos/popular_training_repo_impl.dart'
    as _i75;
import '../../../features/popular_training/domain/repos/popular_training_repo.dart'
    as _i689;
import '../../../features/popular_training/domain/usecases/get_exercises_by_muscle_difficulty_usecase.dart'
    as _i970;
import '../../../features/popular_training/domain/usecases/get_levels_usecase.dart'
    as _i1023;
import '../../../features/popular_training/domain/usecases/get_random_muscles_usecase.dart'
    as _i727;
import '../../../features/popular_training/presentation/view_model/popular_training_cubit.dart'
    as _i590;
import '../../../features/signin/api/datasources/signin_local_data_source_impl.dart'
    as _i709;
import '../../../features/signin/api/datasources/signin_remote_data_source_impl.dart'
    as _i953;
import '../../../features/signin/data/datasources/signin_local_data_source_contract.dart'
    as _i23;
import '../../../features/signin/data/datasources/signin_remote_data_source_contract.dart'
    as _i420;
import '../../../features/signin/data/repositories/signin_repository_impl.dart'
    as _i485;
import '../../../features/signin/domain/repositories/signin_repository.dart'
    as _i64;
import '../../../features/signin/domain/use_cases/signin_use_case.dart'
    as _i983;
import '../../../features/signin/presentation/view_model/cubit/signin_cubit.dart'
    as _i985;
import '../../../features/work_out/api/datasources/work_out_remote_data_source_impl.dart'
    as _i626;
import '../../../features/work_out/data/datasources/work_out_remote_data_source_contract.dart'
    as _i165;
import '../../../features/work_out/data/repositories/work_out_repository_impl.dart'
    as _i292;
import '../../../features/work_out/domain/repositories/work_out_repository.dart'
    as _i845;
import '../../../features/work_out/domain/use_cases/get_all_muscles_by_muscle_group_use_case.dart'
    as _i459;
import '../../../features/work_out/domain/use_cases/get_all_muscles_group_use_case.dart'
    as _i55;
import '../../../features/work_out/presentation/view_model/cubit/work_out_cubit.dart'
    as _i1053;
import '../../core/api_manger/api_client.dart' as _i890;
import '../auth_storage/auth_storage.dart' as _i603;
import '../network/network_module.dart' as _i200;
import 'external_libs_module.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalLibsModule = _$ExternalLibsModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => externalLibsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i603.AuthStorage>(() => _i603.AuthStorage());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i603.AuthStorage>()),
    );
    gh.factory<_i858.AppCubit>(() => _i858.AppCubit(gh<_i603.AuthStorage>()));
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i466.ForgetPasswordRemoteDataSource>(
      () => _i278.ForgetPasswordRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i391.ExerciseRemoteDataSource>(
      () => _i524.ExerciseRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i599.HomeRemoteDataSource>(
      () => _i874.HomeRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i983.ExerciseRepo>(
      () => _i690.ExerciseRepoImpl(gh<_i391.ExerciseRemoteDataSource>()),
    );
    gh.factory<_i435.AuthRemoteDataSourceContract>(
      () => _i339.AuthRemoteDataSourceImpl(apiClient: gh<_i890.ApiClient>()),
    );
    gh.factory<_i165.WorkOutRemoteDataSourceContract>(
      () => _i626.WorkOutRemoteDataSourceImpl(apiClient: gh<_i890.ApiClient>()),
    );
    gh.lazySingleton<_i869.PopularTrainingRemoteDataSource>(
      () => _i723.PopularTrainingRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.lazySingleton<_i689.PopularTrainingRepo>(
      () => _i75.PopularTrainingRepoImpl(
        gh<_i869.PopularTrainingRemoteDataSource>(),
      ),
    );
    gh.factory<_i420.SigninRemoteDataSourceContract>(
      () => _i953.SigninRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i242.HomeRepo>(
      () => _i758.HomeRepoImpl(gh<_i599.HomeRemoteDataSource>()),
    );
    gh.factory<_i23.SigninLocalDataSourceContract>(
      () =>
          _i709.SigninLocalDataSourceImpl(authStorage: gh<_i603.AuthStorage>()),
    );
    gh.factory<_i234.AuthRepository>(
      () => _i365.AuthRepositoryImpl(
        remoteDataSource: gh<_i435.AuthRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i158.MealsRemoteDataSourceContract>(
      () => _i77.MealsRemoteDataSourceImpl(apiClient: gh<_i890.ApiClient>()),
    );
    gh.factory<_i94.GetExercisesRandomUseCase>(
      () => _i94.GetExercisesRandomUseCase(gh<_i983.ExerciseRepo>()),
    );
    gh.factory<_i832.GetExercisesUseCase>(
      () => _i832.GetExercisesUseCase(gh<_i983.ExerciseRepo>()),
    );
    gh.lazySingleton<_i368.EditProfileRemoteDataSource>(
      () => _i474.EditProfileRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.factory<_i845.WorkOutRepository>(
      () => _i292.WorkOutRepositoryImpl(
        remoteDataSource: gh<_i165.WorkOutRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i64.SigninRepository>(
      () => _i485.SigninRepositoryImpl(
        signinLocalDataSource: gh<_i23.SigninLocalDataSourceContract>(),
        signinRemoteDataSourceContract:
            gh<_i420.SigninRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i409.ForgetPasswordRepo>(
      () => _i132.ForgetPasswordRepoImpl(
        gh<_i466.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i485.EditProfileRepo>(
      () => _i202.EditProfileRepoImpl(gh<_i368.EditProfileRemoteDataSource>()),
    );
    gh.factory<_i572.ExerciseCubit>(
      () => _i572.ExerciseCubit(
        gh<_i832.GetExercisesUseCase>(),
        gh<_i94.GetExercisesRandomUseCase>(),
      ),
    );
    gh.factory<_i459.GetAllMusclesByMuscleGroupUseCase>(
      () => _i459.GetAllMusclesByMuscleGroupUseCase(
        gh<_i845.WorkOutRepository>(),
      ),
    );
    gh.factory<_i55.GetAllMusclesGroupUseCase>(
      () => _i55.GetAllMusclesGroupUseCase(gh<_i845.WorkOutRepository>()),
    );
    gh.factory<_i747.ForgetPasswordUseCase>(
      () => _i747.ForgetPasswordUseCase(gh<_i409.ForgetPasswordRepo>()),
    );
    gh.factory<_i347.ResetPasswordUseCase>(
      () => _i347.ResetPasswordUseCase(gh<_i409.ForgetPasswordRepo>()),
    );
    gh.factory<_i225.VerifyCodeUseCase>(
      () => _i225.VerifyCodeUseCase(gh<_i409.ForgetPasswordRepo>()),
    );
    gh.factory<_i970.GetExercisesByMuscleDifficultyUseCase>(
      () => _i970.GetExercisesByMuscleDifficultyUseCase(
        gh<_i689.PopularTrainingRepo>(),
      ),
    );
    gh.factory<_i1023.GetLevelsUseCase>(
      () => _i1023.GetLevelsUseCase(gh<_i689.PopularTrainingRepo>()),
    );
    gh.factory<_i727.GetRandomMusclesUseCase>(
      () => _i727.GetRandomMusclesUseCase(gh<_i689.PopularTrainingRepo>()),
    );
    gh.factory<_i936.MealsRepository>(
      () => _i60.MealsRepositoryImpl(
        remoteDataSource: gh<_i158.MealsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i128.SignupUseCase>(
      () => _i128.SignupUseCase(gh<_i234.AuthRepository>()),
    );
    gh.factory<_i22.SignupCubit>(
      () => _i22.SignupCubit(gh<_i128.SignupUseCase>()),
    );
    gh.factory<_i784.GetRandomMusclesUseCase>(
      () => _i784.GetRandomMusclesUseCase(gh<_i242.HomeRepo>()),
    );
    gh.factory<_i488.ForgetPasswordCubit>(
      () => _i488.ForgetPasswordCubit(
        gh<_i747.ForgetPasswordUseCase>(),
        gh<_i225.VerifyCodeUseCase>(),
        gh<_i347.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i1053.WorkOutCubit>(
      () => _i1053.WorkOutCubit(
        gh<_i55.GetAllMusclesGroupUseCase>(),
        gh<_i459.GetAllMusclesByMuscleGroupUseCase>(),
      ),
    );
    gh.factory<_i276.EditProfileUseCase>(
      () => _i276.EditProfileUseCase(gh<_i485.EditProfileRepo>()),
    );
    gh.factory<_i729.GetLoggedUserDataUseCase>(
      () => _i729.GetLoggedUserDataUseCase(gh<_i485.EditProfileRepo>()),
    );
    gh.factory<_i489.UploadProfileImageUseCase>(
      () => _i489.UploadProfileImageUseCase(gh<_i485.EditProfileRepo>()),
    );
    gh.factory<_i983.SigninUseCase>(
      () => _i983.SigninUseCase(signinRepository: gh<_i64.SigninRepository>()),
    );
    gh.factory<_i956.RcToDayCubit>(
      () => _i956.RcToDayCubit(gh<_i784.GetRandomMusclesUseCase>()),
    );
    gh.factory<_i590.PopularTrainingCubit>(
      () => _i590.PopularTrainingCubit(
        gh<_i727.GetRandomMusclesUseCase>(),
        gh<_i1023.GetLevelsUseCase>(),
        gh<_i970.GetExercisesByMuscleDifficultyUseCase>(),
      ),
    );
    gh.factory<_i1023.GetMealDetailsByIdUsecase>(
      () => _i1023.GetMealDetailsByIdUsecase(
        mealsRepository: gh<_i936.MealsRepository>(),
      ),
    );
    gh.factory<_i447.GetMealsByCategoryUsecase>(
      () => _i447.GetMealsByCategoryUsecase(
        mealsRepository: gh<_i936.MealsRepository>(),
      ),
    );
    gh.factory<_i601.GetMealsCategoriesUsecase>(
      () => _i601.GetMealsCategoriesUsecase(
        mealsRepository: gh<_i936.MealsRepository>(),
      ),
    );
    gh.factory<_i985.SigninCubit>(
      () => _i985.SigninCubit(signinUseCase: gh<_i983.SigninUseCase>()),
    );
    gh.factory<_i316.MealsCubit>(
      () => _i316.MealsCubit(
        gh<_i601.GetMealsCategoriesUsecase>(),
        gh<_i447.GetMealsByCategoryUsecase>(),
        gh<_i1023.GetMealDetailsByIdUsecase>(),
      ),
    );
    return this;
  }
}

class _$ExternalLibsModule extends _i993.ExternalLibsModule {}

class _$NetworkModule extends _i200.NetworkModule {}
