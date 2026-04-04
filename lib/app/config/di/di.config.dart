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
import '../../core/api_manger/api_client.dart' as _i890;
import '../auth_storage/auth_storage.dart' as _i603;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i603.AuthStorage>(
      () => _i603.AuthStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i603.AuthStorage>()),
    );
    gh.lazySingleton<_i890.ApiClient>(
      () => networkModule.authApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i466.ForgetPasswordRemoteDataSource>(
      () => _i278.ForgetPasswordRemoteDataSourceImpl(gh<_i890.ApiClient>()),
    );
    gh.lazySingleton<_i409.ForgetPasswordRepo>(
      () => _i132.ForgetPasswordRepoImpl(
        gh<_i466.ForgetPasswordRemoteDataSource>(),
      ),
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
    gh.factory<_i488.ForgetPasswordCubit>(
      () => _i488.ForgetPasswordCubit(
        gh<_i747.ForgetPasswordUseCase>(),
        gh<_i225.VerifyCodeUseCase>(),
        gh<_i347.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
