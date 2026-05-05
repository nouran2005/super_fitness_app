import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_categories_usecase.dart';

import 'get_meals_categories_usecase_test.mocks.dart';

@GenerateMocks([MealsRepository])
void main() {
  late MockMealsRepository mockRepository;
  late GetMealsCategoriesUsecase usecase;

  setUp(() {
    mockRepository = MockMealsRepository();
    usecase = GetMealsCategoriesUsecase(mealsRepository: mockRepository);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealsCategoriesModel>>(
      SuccessApiResult<MealsCategoriesModel>(data: MealsCategoriesModel()),
    );
  });

  final tCategoriesModel = MealsCategoriesModel(
    categories: [
      CategoriesModel(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb: "thumb",
        strCategoryDescription: "desc",
      ),
    ],
  );

  group("GetMealsCategoriesUsecase", () {
    test('should return SuccessApiResult when repository succeeds', () async {
      when(
        mockRepository.getMealsCategories(),
      ).thenAnswer((_) async => SuccessApiResult(data: tCategoriesModel));

      final result = await usecase();

      expect(result, isA<SuccessApiResult<MealsCategoriesModel>>());
      final data = (result as SuccessApiResult<MealsCategoriesModel>).data;
      expect(data.categories?.first?.strCategory, "Beef");
      verify(mockRepository.getMealsCategories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ErrorApiResult when repository fails', () async {
      when(
        mockRepository.getMealsCategories(),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await usecase();

      expect(result, isA<ErrorApiResult<MealsCategoriesModel>>());
      expect((result as ErrorApiResult).error, "error");
      verify(mockRepository.getMealsCategories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
