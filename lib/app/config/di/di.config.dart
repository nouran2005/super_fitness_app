// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

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
    gh.factory<_i435.AuthRemoteDataSourceContract>(
      () => _i339.AuthRemoteDataSourceImpl(apiClient: gh<_i890.ApiClient>()),
    );
    gh.factory<_i165.WorkOutRemoteDataSourceContract>(
      () => _i626.WorkOutRemoteDataSourceImpl(apiClient: gh<_i890.ApiClient>()),
    );
    gh.factory<_i420.SigninRemoteDataSourceContract>(
      () => _i953.SigninRemoteDataSourceImpl(gh<_i890.ApiClient>()),
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
    gh.factory<_i128.SignupUseCase>(
      () => _i128.SignupUseCase(gh<_i234.AuthRepository>()),
    );
    gh.factory<_i22.SignupCubit>(
      () => _i22.SignupCubit(gh<_i128.SignupUseCase>()),
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
    gh.factory<_i983.SigninUseCase>(
      () => _i983.SigninUseCase(signinRepository: gh<_i64.SigninRepository>()),
    );
    gh.factory<_i985.SigninCubit>(
      () => _i985.SigninCubit(signinUseCase: gh<_i983.SigninUseCase>()),
    );
    return this;
  }
}

class _$ExternalLibsModule extends _i993.ExternalLibsModule {}

class _$NetworkModule extends _i200.NetworkModule {}
