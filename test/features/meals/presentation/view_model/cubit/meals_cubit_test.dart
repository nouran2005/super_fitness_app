import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_categories_usecase.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_by_category_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

import 'meals_cubit_test.mocks.dart';

@GenerateMocks([GetMealsCategoriesUsecase, GetMealsByCategoryUsecase])
void main() {
  late MockGetMealsCategoriesUsecase mockCategoriesUsecase;
  late MockGetMealsByCategoryUsecase mockByCategoryUsecase;
  late MealsCubit cubit;

  setUp(() {
    mockCategoriesUsecase = MockGetMealsCategoriesUsecase();
    mockByCategoryUsecase = MockGetMealsByCategoryUsecase();

    cubit = MealsCubit(mockCategoriesUsecase, mockByCategoryUsecase);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealsByCategoryModel>>(
      SuccessApiResult<MealsByCategoryModel>(data: MealsByCategoryModel()),
    );

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
      CategoriesModel(idCategory: "2", strCategory: "Chicken"),
    ],
  );

  final tMealsModel = MealsByCategoryModel(
    meals: [
      MealsModel(strMeal: "Chicken Soup", strMealThumb: "img", idMeal: "10"),
    ],
  );

  group("GetMealsCategoriesIntent", () {
    blocTest<MealsCubit, MealsStates>(
      'emits [loading → success + selectedIndex]',
      build: () {
        when(
          mockCategoriesUsecase.call(),
        ).thenAnswer((_) async => SuccessApiResult(data: tCategoriesModel));

        when(
          mockByCategoryUsecase.call(category: anyNamed('category')),
        ).thenAnswer((_) async => SuccessApiResult(data: tMealsModel));

        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetMealsCategoriesIntent(initialIndex: 0)),
      expect: () => [
        isA<MealsStates>().having(
          (s) => s.mealsCategoriesResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealsCategoriesResource.status,
          'success',
          Status.success,
        ),
        isA<MealsStates>().having(
          (s) => s.mealsByCategoryResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealsByCategoryResource.status,
          'success',
          Status.success,
        ),
      ],
      verify: (_) {
        verify(mockCategoriesUsecase.call()).called(1);
      },
    );

    blocTest<MealsCubit, MealsStates>(
      'emits error when categories fail',
      build: () {
        when(
          mockCategoriesUsecase.call(),
        ).thenAnswer((_) async => ErrorApiResult(error: "error"));

        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetMealsCategoriesIntent()),
      expect: () => [
        isA<MealsStates>().having(
          (s) => s.mealsCategoriesResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealsCategoriesResource.status,
          'error',
          Status.error,
        ),
      ],
    );
  });

  group("SelectCategoryEvent", () {
    blocTest<MealsCubit, MealsStates>(
      'emits selectedIndex + meals success',
      build: () {
        when(
          mockByCategoryUsecase.call(category: anyNamed('category')),
        ).thenAnswer((_) async => SuccessApiResult(data: tMealsModel));

        return cubit;
      },
      seed: () => MealsStates(
        selectedIndex: 0,
        mealsCategoriesResource: Resource.success(tCategoriesModel),
      ),
      act: (cubit) => cubit.doIntent(SelectCategoryEvent(selectedIndex: 1)),
      expect: () => [
        isA<MealsStates>().having((s) => s.selectedIndex, 'index', 1),
        isA<MealsStates>().having(
          (s) => s.mealsByCategoryResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealsByCategoryResource.status,
          'success',
          Status.success,
        ),
      ],
      verify: (_) {
        verify(
          mockByCategoryUsecase.call(category: anyNamed('category')),
        ).called(1);
      },
    );
  });
}
