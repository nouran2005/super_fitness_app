import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/data/dataScources/home_remote_data_source.dart';
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';
import 'package:super_fitness_app/features/home/data/repo/home_repo_impl.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepoImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepoImpl(mockRemoteDataSource);
  });

  test(
    'should return RecommendationEntity when remote fetch is successful',
    () async {
      final model = RecommendationToDay(message: 'Success', muscles: []);
      when(
        mockRemoteDataSource.getRandomMuscles(),
      ).thenAnswer((_) async => model);

      final result = await repository.getRandomMuscles();

      expect(result.message, 'Success');
      verify(mockRemoteDataSource.getRandomMuscles()).called(1);
    },
  );
}
