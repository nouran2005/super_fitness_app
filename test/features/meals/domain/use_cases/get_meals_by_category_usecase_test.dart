import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_by_category_usecase.dart';

import 'get_meals_by_category_usecase_test.mocks.dart';

@GenerateMocks([MealsRepository])
void main() {
  late MockMealsRepository mockRepository;
  late GetMealsByCategoryUsecase usecase;

  setUp(() {
    mockRepository = MockMealsRepository();
    usecase = GetMealsByCategoryUsecase(mealsRepository: mockRepository);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealsByCategoryModel>>(
      SuccessApiResult<MealsByCategoryModel>(data: MealsByCategoryModel()),
    );
  });

  const tCategory = "Beef";

  final tMealsModel = MealsByCategoryModel(
    meals: [
      MealsModel(strMeal: "Chicken Soup", strMealThumb: "img", idMeal: "10"),
    ],
  );

  group("GetMealsByCategoryUsecase", () {
    test('should return SuccessApiResult when repository succeeds', () async {
      when(
        mockRepository.getMealsByCategory(tCategory),
      ).thenAnswer((_) async => SuccessApiResult(data: tMealsModel));

      final result = await usecase(category: tCategory);

      expect(result, isA<SuccessApiResult<MealsByCategoryModel>>());

      final data = (result as SuccessApiResult<MealsByCategoryModel>).data;

      expect(data.meals?.first?.strMeal, "Chicken Soup");

      verify(mockRepository.getMealsByCategory(tCategory)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ErrorApiResult when repository fails', () async {
      when(
        mockRepository.getMealsByCategory(tCategory),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await usecase(category: tCategory);

      expect(result, isA<ErrorApiResult<MealsByCategoryModel>>());

      expect((result as ErrorApiResult).error, "error");

      verify(mockRepository.getMealsByCategory(tCategory)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
