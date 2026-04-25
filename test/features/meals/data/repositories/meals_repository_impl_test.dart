import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/datasources/meals_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/data/repositories/meals_repository_impl.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

import 'meals_repository_impl_test.mocks.dart';

@GenerateMocks([MealsRemoteDataSourceContract])
void main() {
  late MockMealsRemoteDataSourceContract mockDataSource;
  late MealsRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockMealsRemoteDataSourceContract();
    repository = MealsRepositoryImpl(remoteDataSource: mockDataSource);
  });
  setUpAll(() {
    provideDummy<ApiResult<MealsCategoriesDto>>(
      SuccessApiResult<MealsCategoriesDto>(data: MealsCategoriesDto()),
    );
    provideDummy<ApiResult<MealsByCategoryDto>>(
      SuccessApiResult<MealsByCategoryDto>(data: MealsByCategoryDto()),
    );
  });
  group("MealsRepositoryImpl.getMealsCategories", () {
    final tCategoriesDto = MealsCategoriesDto(
      categories: [
        CategoriesDto(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb: "thumb",
          strCategoryDescription: "desc",
        ),
      ],
    );

    test(
      'should return SuccessApiResult<MealsCategoriesModel> when success',
      () async {
        when(
          mockDataSource.getMealsCategories(),
        ).thenAnswer((_) async => SuccessApiResult(data: tCategoriesDto));

        final result = await repository.getMealsCategories();

        expect(result, isA<SuccessApiResult<MealsCategoriesModel>>());

        final data = (result as SuccessApiResult<MealsCategoriesModel>).data;

        expect(data.categories?.first?.strCategory, "Beef");

        verify(mockDataSource.getMealsCategories()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('should return ErrorApiResult when fails', () async {
      when(
        mockDataSource.getMealsCategories(),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await repository.getMealsCategories();

      expect(result, isA<ErrorApiResult<MealsCategoriesModel>>());

      expect((result as ErrorApiResult).error, "error");

      verify(mockDataSource.getMealsCategories()).called(1);
    });
  });

  group("MealsRepositoryImpl.getMealsByCategory", () {
    final tMealsDto = MealsByCategoryDto(
      meals: [
        MealsDto(strMeal: "Chicken Soup", strMealThumb: "img", idMeal: "10"),
      ],
    );

    test('should return SuccessApiResult<MealsByCategoryModel>', () async {
      when(
        mockDataSource.getMealsByCategory(any),
      ).thenAnswer((_) async => SuccessApiResult(data: tMealsDto));

      final result = await repository.getMealsByCategory("Beef");

      expect(result, isA<SuccessApiResult<MealsByCategoryModel>>());

      final data = (result as SuccessApiResult<MealsByCategoryModel>).data;

      expect(data.meals?.first?.strMeal, "Chicken Soup");

      verify(mockDataSource.getMealsByCategory(any)).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return ErrorApiResult when fails', () async {
      when(
        mockDataSource.getMealsByCategory(any),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await repository.getMealsByCategory("Beef");

      expect(result, isA<ErrorApiResult<MealsByCategoryModel>>());

      expect((result as ErrorApiResult).error, "error");

      verify(mockDataSource.getMealsByCategory(any)).called(1);
    });
  });
}
