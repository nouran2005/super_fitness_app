import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_section_placeholder.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_sections_bottom_nav_bar.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/presentation/pages/HomeScreen.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import '../../../../../helpers/pump_app.dart';

class MockWorkOutCubit extends Mock implements WorkOutCubit {}

class MockRcToDayCubit extends Mock implements RcToDayCubit {}

class MockPopularTrainingCubit extends Mock implements PopularTrainingCubit {}

void main() {
  late MockWorkOutCubit mockWorkOutCubit;
  late MockRcToDayCubit mockRcToDayCubit;
  late MockPopularTrainingCubit mockPopularTrainingCubit;

  setUp(() async {
    await getIt.reset();
    mockWorkOutCubit = MockWorkOutCubit();
    mockRcToDayCubit = MockRcToDayCubit();
    mockPopularTrainingCubit = MockPopularTrainingCubit();
    getIt.registerSingleton<WorkOutCubit>(mockWorkOutCubit);
    getIt.registerSingleton<RcToDayCubit>(mockRcToDayCubit);
    getIt.registerSingleton<PopularTrainingCubit>(mockPopularTrainingCubit);

    when(() => mockWorkOutCubit.state).thenReturn(WorkOutStates());
    when(() => mockWorkOutCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockWorkOutCubit.close()).thenAnswer((_) async {});

    when(
      () => mockRcToDayCubit.state,
    ).thenReturn(RcToDayStates(recommendationResource: Resource.initial()));
    when(() => mockRcToDayCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockRcToDayCubit.close()).thenAnswer((_) async {});

    when(
      () => mockPopularTrainingCubit.state,
    ).thenReturn(PopularTrainingState(popularExercises: Resource.initial()));
    when(
      () => mockPopularTrainingCubit.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => mockPopularTrainingCubit.close()).thenAnswer((_) async {});
  });

  group('AppSectionsView', () {
    Future<void> pumpView(WidgetTester tester, AppSectionsCubit cubit) async {
      await tester.pumpLocalizedWidget(
        BlocProvider.value(value: cubit, child: const AppSectionsView()),
        settle: false,
      );
      await tester.pump();
    }

    Finder navTapTarget(int index) {
      return find
          .descendant(
            of: find.byType(AppSectionsBottomNavBar),
            matching: find.byType(InkWell),
          )
          .at(index);
    }

    testWidgets('uses the cubit state to choose the visible section', (
      tester,
    ) async {
      final cubit = AppSectionsCubit()..changePage(1);
      addTearDown(cubit.close);

      await pumpView(tester, cubit);

      final indexedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );

      expect(indexedStack.index, 1);
      expect(
        find.byType(AppSectionPlaceholder, skipOffstage: false),
        findsNWidgets(2),
      );
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.text(appSectionDestinations[1].subtitle), findsOneWidget);
      expect(find.text(appSectionDestinations.first.subtitle), findsNothing);
    });

    //   testWidgets('changes the page when a destination is tapped', (
    //     tester,
    //   ) async {
    //     final cubit = AppSectionsCubit();
    //     addTearDown(cubit.close);

    //     await pumpView(tester, cubit);

    //     await tester.tap(navTapTarget(2));
    //     await tester.pump(); // Start transition
    //     await tester.pump(
    //       const Duration(milliseconds: 300),
    //     ); // Finish transition if any

    //     final indexedStack = tester.widget<IndexedStack>(
    //       find.byType(IndexedStack),
    //     );

    //     expect(cubit.state.currentIndex, 2);
    //     expect(indexedStack.index, 2);
    //     // Index 2 is WorkOutPage, so check for "Workouts" title
    //     expect(find.byType(WorkOutPage), findsOneWidget);
    //     expect(find.text(appSectionDestinations.first.subtitle), findsNothing);
    //   });
  });
}
