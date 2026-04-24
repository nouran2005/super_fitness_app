import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/features/home/api/home_remote_data_source_imp.dart';
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';
import 'package:retrofit/retrofit.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = HomeRemoteDataSourceImpl(mockApiClient);
  });

  test('should call getRandomMuscles on ApiClient with correct language', () async {
    final model = RecommendationToDay(message: 'Success');
    final response = HttpResponse(model, Response(requestOptions: RequestOptions(path: '')));
    
    when(mockApiClient.getRandomMuscles('en')).thenAnswer((_) async => response);

    final result = await dataSource.getRandomMuscles();

    expect(result, model);
    verify(mockApiClient.getRandomMuscles('en')).called(1);
  });
}
