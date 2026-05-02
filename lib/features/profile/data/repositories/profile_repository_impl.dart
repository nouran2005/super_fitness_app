import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/data/datasources/profile_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/profile/data/extension/profile_data_dto_extension.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSourceContract remoteDataSource;
  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ProfileDataModel>> getProfileData(String token) async {
    final response = await remoteDataSource.getProfileData(token);

    switch (response) {
      case SuccessApiResult<ProfileDataDto>():
        ProfileDataDto dto = response.data;
        ProfileDataModel meal = dto.toProfileDataModel();
        return SuccessApiResult<ProfileDataModel>(data: meal);

      case ErrorApiResult<ProfileDataDto>():
        return ErrorApiResult<ProfileDataModel>(
          error: response.error.toString(),
        );
    }
  }

  @override
  Future<String> helpData() async {
    return await remoteDataSource.helpData();
  }

  @override
  Future<String> privacyData() async {
    return await remoteDataSource.privacyData();
  }

  @override
  Future<String> securityData() async {
    return await remoteDataSource.securityData();
  }
}
