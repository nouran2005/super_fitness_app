import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

import 'meal_details_page_test.mocks.dart';

/*
@GenerateMocks([MealsCubit])
void main() {
  late MockMealsCubit mockCubit;

  setUp(() async {
    await getIt.reset();

    mockCubit = MockMealsCubit();

    getIt.registerFactory<MealsCubit>(() => mockCubit);

    when(mockCubit.stream).thenAnswer((_) => const Stream<MealsStates>.empty());
  });

  Widget buildWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        home: BlocProvider<MealsCubit>(
          create: (_) => mockCubit,
          child: const Scaffold(
            body: MealDetailsBody(mealId: "1", meals: []),
          ),
        ),
      ),
    );
  }

  group("MealDetailsBody Widget Tests", () {
    testWidgets('should show loading indicator', (tester) async {
      when(
        mockCubit.state,
      ).thenReturn(MealsStates(mealDetailsResource: Resource.loading()));

      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render meal details correctly', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          mealDetailsResource: Resource.success(
            MealDetailsModel(
              meals: [
                DetailsModel(
                  strMeal: "Chicken Soup",
                  strMealThumb: "https://image.com",
                  strYoutube: "https://youtube.com",
                  strIngredient1: "Chicken",
                  strMeasure1: "1kg",
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.text('Chicken Soup'), findsOneWidget);
      expect(find.byType(VideoLaunchWidget), findsOneWidget);
      expect(find.byType(MealsIngredientsList), findsOneWidget);
    });

    testWidgets('should show error state', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          mealDetailsResource: Resource.error("Something went wrong"),
        ),
      );

      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.text("Something went wrong"), findsOneWidget);
    });

    testWidgets('should render UI structure', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          mealDetailsResource: Resource.success(
            MealDetailsModel(
              meals: [
                DetailsModel(
                  strMeal: "Meal",
                  strMealThumb: "https://image.com",
                  strYoutube: "https://youtube.com/video",
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Image), findsWidgets);

      expect(find.text('Meal'), findsOneWidget);
    });
  });
}
*/
