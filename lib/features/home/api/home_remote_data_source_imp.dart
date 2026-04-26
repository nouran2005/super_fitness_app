import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/features/home/data/dataScources/home_remote_data_source.dart';
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<RecommendationToDay> getRandomMuscles() async {
    final response = await _apiClient.getRandomMuscles('en');
    return response.data;
  }
}
