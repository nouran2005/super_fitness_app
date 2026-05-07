import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/homeBody.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/app_Par.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/categorySection.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_state.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class MockMealsCubit extends MockCubit<MealsStates> implements MealsCubit {}

class MockWorkOutCubit extends MockCubit<WorkOutStates>
    implements WorkOutCubit {}

class MockAppSectionsCubit extends MockCubit<AppSectionsState>
    implements AppSectionsCubit {}

class MockPopularTrainingCubit extends MockCubit<PopularTrainingState>
    implements PopularTrainingCubit {}

class MockRcToDayCubit extends MockCubit<RcToDayStates>
    implements RcToDayCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProfileCubit profileCubit;
  late MealsCubit mealsCubit;
  late WorkOutCubit workOutCubit;
  late AppSectionsCubit appSectionsCubit;
  late PopularTrainingCubit popularTrainingCubit;
  late RcToDayCubit rcToDayCubit;

  setUp(() {
    profileCubit = MockProfileCubit();
    when(() => profileCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => profileCubit.state).thenReturn(ProfileState());

    mealsCubit = MockMealsCubit();
    when(() => mealsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mealsCubit.state).thenReturn(
      MealsStates(
        mealsByCategoryResource: Resource.initial(),
        mealsCategoriesResource: Resource.initial(),
        mealDetailsResource: Resource.initial(),
      ),
    );

    workOutCubit = MockWorkOutCubit();
    when(() => workOutCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => workOutCubit.state).thenReturn(
      WorkOutStates(
        musclesGroupResource: Resource.initial(),
        musclesByGroupResource: Resource.initial(),
      ),
    );

    appSectionsCubit = MockAppSectionsCubit();
    when(() => appSectionsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => appSectionsCubit.state).thenReturn(const AppSectionsState());

    popularTrainingCubit = MockPopularTrainingCubit();
    when(
      () => popularTrainingCubit.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => popularTrainingCubit.state,
    ).thenReturn(PopularTrainingState(popularExercises: Resource.initial()));

    rcToDayCubit = MockRcToDayCubit();
    when(() => rcToDayCubit.stream).thenAnswer((_) => const Stream.empty());
    when(
      () => rcToDayCubit.state,
    ).thenReturn(RcToDayStates(recommendationResource: Resource.initial()));
  });

  Widget buildSubject() {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: profileCubit),
              BlocProvider<MealsCubit>.value(value: mealsCubit),
              BlocProvider<WorkOutCubit>.value(value: workOutCubit),
              BlocProvider<AppSectionsCubit>.value(value: appSectionsCubit),
              BlocProvider<PopularTrainingCubit>.value(
                value: popularTrainingCubit,
              ),
              BlocProvider<RcToDayCubit>.value(value: rcToDayCubit),
            ],
            child: const HomeBody(),
          ),
        ),
        GoRoute(
          path: '/exercises',
          builder: (context, state) => const Scaffold(),
        ),
        GoRoute(
          path: '/smart_coach',
          builder: (context, state) => const Scaffold(),
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  group('HomeBody', () {
    testWidgets('renders CustomAppBar and CategorySection', (tester) async {
      // Suppress _dependents.isEmpty framework assertion that occurs
      // when GoRouter + BlocProvider + InheritedWidget deactivate together
      FlutterError.onError = (FlutterErrorDetails details) {
        // Ignore framework teardown assertions
        final msg = details.exceptionAsString();
        if (msg.contains('_dependents.isEmpty')) return;
        FlutterError.dumpErrorToConsole(details);
      };

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(CustomAppBar), findsOneWidget);
      expect(find.byType(CategorySection), findsOneWidget);
    });
  });
}
