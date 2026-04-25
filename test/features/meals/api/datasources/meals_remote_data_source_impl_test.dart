import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/api/datasources/meals_remote_data_source_impl.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';

import 'meals_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MealsRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = MealsRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group("MealsRemoteDataSourceImpl", () {
    group("getMealsCategories", () {
      test(
        'should return ApiSuccess when getMealsCategories succeeds',
        () async {
          final fakeDto = MealsCategoriesDto();

          final fakeResponse = HttpResponse(
            fakeDto,
            Response(
              requestOptions: RequestOptions(path: '/meals/categories'),
              statusCode: 200,
            ),
          );

          when(
            mockApiClient.getMealsCategories(),
          ).thenAnswer((_) async => fakeResponse);

          final result =
              await dataSource.getMealsCategories()
                  as SuccessApiResult<MealsCategoriesDto>;

          expect(result, isA<SuccessApiResult<MealsCategoriesDto>>());
          expect(result.data, fakeDto);

          verify(mockApiClient.getMealsCategories()).called(1);
        },
      );

      test(
        'should return ApiFailure when getMealsCategories throws exception',
        () async {
          when(
            mockApiClient.getMealsCategories(),
          ).thenThrow(Exception('Network error'));

          final result =
              await dataSource.getMealsCategories()
                  as ErrorApiResult<MealsCategoriesDto>;

          expect(result, isA<ErrorApiResult<MealsCategoriesDto>>());
          expect(result.error.toString(), contains("Network error"));

          verify(mockApiClient.getMealsCategories()).called(1);
        },
      );
    });

    group("getMealsByCategory", () {
      test(
        'should return ApiSuccess when getMealsByCategory succeeds',
        () async {
          final fakeDto = MealsByCategoryDto();

          final fakeResponse = HttpResponse(
            fakeDto,
            Response(
              requestOptions: RequestOptions(path: '/meals/by-category'),
              statusCode: 200,
            ),
          );

          when(
            mockApiClient.getMealsByCategory(any),
          ).thenAnswer((_) async => fakeResponse);

          final result =
              await dataSource.getMealsByCategory("Beef")
                  as SuccessApiResult<MealsByCategoryDto>;

          expect(result, isA<SuccessApiResult<MealsByCategoryDto>>());
          expect(result.data, fakeDto);

          verify(mockApiClient.getMealsByCategory(any)).called(1);
        },
      );

      test(
        'should return ApiFailure when getMealsByCategory throws exception',
        () async {
          when(
            mockApiClient.getMealsByCategory(any),
          ).thenThrow(Exception('Network error'));

          final result =
              await dataSource.getMealsByCategory("Beef")
                  as ErrorApiResult<MealsByCategoryDto>;

          expect(result, isA<ErrorApiResult<MealsByCategoryDto>>());
          expect(result.error.toString(), contains("Network error"));

          verify(mockApiClient.getMealsByCategory(any)).called(1);
        },
      );
    });
  });
}
