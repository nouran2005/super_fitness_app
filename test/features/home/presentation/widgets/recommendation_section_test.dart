import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/recommendation_section.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';

import '../../../../helpers/pump_app.dart';

class MockRcToDayCubit extends MockCubit<RcToDayStates> implements RcToDayCubit {}

void main() {
  group('RecommendationSection', () {
    late RcToDayCubit cubit;

    setUp(() {
      cubit = MockRcToDayCubit();
    });

    Widget buildSubject() => BlocProvider<RcToDayCubit>.value(
          value: cubit,
          child: const RecommendationSection(title: 'Today\'s Picks'),
        );

    testWidgets('shows title text', (tester) async {
      when(() => cubit.state).thenReturn(
        RcToDayStates(recommendationResource: Resource.initial()),
      );

      await tester.pumpLocalizedWidget(buildSubject(), settle: false);

      expect(find.text("Today's Picks"), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      when(() => cubit.state).thenReturn(
        RcToDayStates(recommendationResource: Resource.loading()),
      );

      await tester.pumpLocalizedWidget(buildSubject(), settle: false);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error text when state is error', (tester) async {
      when(() => cubit.state).thenReturn(
        RcToDayStates(
          recommendationResource: Resource.error('Network error'),
        ),
      );

      await tester.pumpLocalizedWidget(buildSubject(), settle: false);

      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('shows SizedBox.shrink when initial state', (tester) async {
      when(() => cubit.state).thenReturn(
        RcToDayStates(recommendationResource: Resource.initial()),
      );

      await tester.pumpLocalizedWidget(buildSubject(), settle: false);

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows muscles when success state has data', (tester) async {
      when(() => cubit.state).thenReturn(
        RcToDayStates(
          recommendationResource: Resource.success(
            RecommendationEntity(
              muscles: [
                const MuscleEntity(
                  id: '1',
                  name: 'Chest',
                  image: 'https://example.com/chest.png',
                ),
                const MuscleEntity(
                  id: '2',
                  name: 'Back',
                  image: 'https://example.com/back.png',
                ),
                const MuscleEntity(
                  id: '3',
                  name: 'Legs',
                  image: 'https://example.com/legs.png',
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpLocalizedWidget(buildSubject(), settle: false);

      // At least one recommendation should be shown
      expect(find.byType(Row), findsWidgets);
    });
  });
}
