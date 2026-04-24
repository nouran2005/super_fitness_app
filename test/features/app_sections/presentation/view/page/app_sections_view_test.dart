import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_section_placeholder.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_sections_bottom_nav_bar.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/presentation/pages/HomeScreen.dart';

import 'app_sections_view_test.mocks.dart';

@GenerateMocks([RcToDayCubit])

import '../../../../../helpers/pump_app.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    final mockRcToDayCubit = MockRcToDayCubit();
    getIt.registerSingleton<RcToDayCubit>(mockRcToDayCubit);

    when(mockRcToDayCubit.state).thenReturn(RcToDayStates(recommendationResource: Resource.initial()));
    when(mockRcToDayCubit.stream).thenAnswer((_) => Stream.empty());
  });

  group('AppSectionsView', () {
    Future<void> pumpView(WidgetTester tester, AppSectionsCubit cubit) async {
      await tester.pumpLocalizedWidget(
        BlocProvider.value(value: cubit, child: const AppSectionsView()),
      );
      await tester.pumpAndSettle();
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
        findsNWidgets(appSectionDestinations.length - 1),
      );
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.text(appSectionDestinations[1].subtitle), findsOneWidget);
      expect(find.text(appSectionDestinations.first.subtitle), findsNothing);
    });

    testWidgets('changes the page when a destination is tapped', (
      tester,
    ) async {
      final cubit = AppSectionsCubit();
      addTearDown(cubit.close);

      await pumpView(tester, cubit);

      await tester.tap(navTapTarget(2));
      await tester.pumpAndSettle();

      final indexedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );

      expect(cubit.state.currentIndex, 2);
      expect(indexedStack.index, 2);
      expect(find.text(appSectionDestinations[2].subtitle), findsOneWidget);
      expect(find.text(appSectionDestinations.first.subtitle), findsNothing);
    });
  });
}
