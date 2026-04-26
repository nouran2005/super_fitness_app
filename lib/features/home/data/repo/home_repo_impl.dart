import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/home/data/dataScources/home_remote_data_source.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';
import 'package:super_fitness_app/features/home/domain/repo/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepoImpl(this._remoteDataSource);

  @override
  Future<RecommendationEntity> getRandomMuscles() async {
    final response = await _remoteDataSource.getRandomMuscles();
    return response.toEntity();
  }
}
