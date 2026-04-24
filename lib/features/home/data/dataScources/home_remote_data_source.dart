
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';

abstract class HomeRemoteDataSource {
  Future<RecommendationToDay> getRandomMuscles();
}
