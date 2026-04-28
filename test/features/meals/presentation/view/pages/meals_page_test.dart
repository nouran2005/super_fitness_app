/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/meals/presentation/view/pages/meals_page.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/categories_tab_bar.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

import 'meals_page_test.mocks.dart';

@GenerateMocks([MealsCubit])
void main() {
  late MockMealsCubit mealsCubit;

  setUp(() async {
    await getIt.reset();
    mealsCubit = MockMealsCubit();
    getIt.registerFactory<MealsCubit>(() => mealsCubit);

    when(mealsCubit.state).thenReturn(
      MealsStates(
        selectedIndex: 0,
        mealsCategoriesResource: Resource.success(
          MealsCategoriesModel(
            categories: [
              CategoriesModel(idCategory: "1", strCategory: "Beef"),
              CategoriesModel(idCategory: "2", strCategory: "Chicken"),
            ],
          ),
        ),
        mealsByCategoryResource: Resource.success(
          MealsByCategoryModel(
            meals: [
              MealsModel(
                strMeal: "Chicken Soup",
                strMealThumb: "https://img.com",
                idMeal: "1",
              ),
            ],
          ),
        ),
      ),
    );

    when(
      mealsCubit.stream,
    ).thenAnswer((_) => const Stream<MealsStates>.empty());
  });

  Widget buildTestWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        home: BlocProvider<MealsCubit>(
          create: (_) => mealsCubit,
          child: const MealsPage(),
        ),
      ),
    );
  }

  group("Meals Page UI Test", () {
    testWidgets('should render meals page UI correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MealsPage), findsOneWidget);
      expect(find.textContaining('foodRecommendation'), findsOneWidget);
      expect(find.byType(CategoriesTabBar), findsOneWidget);
      expect(find.byType(MealsList), findsOneWidget);
    });

    testWidgets('should display categories tabs', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Beef'), findsOneWidget);
      expect(find.text('Chicken'), findsOneWidget);
    });

    testWidgets('should display meal item', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Chicken Soup'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should show image and layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
    });
  });
}
*/