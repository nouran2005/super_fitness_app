import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meals_body.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

import 'meals_body_test.mocks.dart';

@GenerateMocks([MealsCubit])
void main() {
  late MockMealsCubit mockCubit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockMealsCubit();

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTest(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: BlocProvider<MealsCubit>.value(
        value: mockCubit,
        child: MaterialApp(home: Scaffold(body: child)),
      ),
    );
  }

  // Fake Data
  MealsStates buildSuccessState() {
    return MealsStates(
      selectedIndex: 0,
      mealsCategoriesResource: Resource.success(
        MealsCategoriesModel(
          categories: [
            CategoriesModel(strCategory: "Beef"),
            CategoriesModel(strCategory: "Chicken"),
          ],
        ),
      ),
      mealsByCategoryResource: Resource.success(
        MealsByCategoryModel(
          meals: [
            MealsModel(
              idMeal: "1",
              strMeal: "Meal 1",
              strMealThumb: "https://test.com/image.jpg",
            ),
            MealsModel(
              idMeal: "2",
              strMeal: "Meal 2",
              strMealThumb: "https://test.com/image.jpg",
            ),
          ],
        ),
      ),
    );
  }

  group('Meals Widgets Test', () {
    testWidgets('renders full MealsBody with data', (tester) async {
      final state = buildSuccessState();

      when(mockCubit.state).thenReturn(state);

      await tester.pumpWidget(buildTest(const MealsBody()));
      await tester.pumpAndSettle();

      expect(find.textContaining('food'), findsOneWidget);

      expect(find.text('Beef'), findsOneWidget);
      expect(find.text('Chicken'), findsOneWidget);

      expect(find.text('Meal 1'), findsOneWidget);
      expect(find.text('Meal 2'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          selectedIndex: 0,
          mealsCategoriesResource: Resource.loading(),
          mealsByCategoryResource: Resource.loading(),
        ),
      );

      await tester.pumpWidget(buildTest(const MealsBody()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows empty state', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          selectedIndex: 0,
          mealsCategoriesResource: Resource.success(
            MealsCategoriesModel(categories: []),
          ),
          mealsByCategoryResource: Resource.success(
            MealsByCategoryModel(meals: []),
          ),
        ),
      );

      await tester.pumpWidget(buildTest(const MealsBody()));
      await tester.pumpAndSettle();

      expect(find.textContaining('no'), findsOneWidget);
    });
  });
}
