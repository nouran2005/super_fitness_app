import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_category_tabs.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_stats_row.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/video_overlay.dart';

import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('Exercise Widgets', () {
    testWidgets('ExerciseCategoryTabs renders options and handles tap', (tester) async {
      int selectedIndex = 0;
      await tester.pumpLocalizedWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return ExerciseCategoryTabs(
              categories: const [
                ExerciseCategoryEntity(name: 'Beginner', exercises: []),
                ExerciseCategoryEntity(name: 'Intermediate', exercises: []),
                ExerciseCategoryEntity(name: 'Advance', exercises: []),
              ],
              selectedCategoryIndex: selectedIndex,
              onCategorySelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            );
          },
        ),
      );

      expect(find.text('Beginner'), findsOneWidget);
      expect(find.text('Intermediate'), findsOneWidget);
      expect(find.text('Advance'), findsOneWidget);

      await tester.tap(find.text('Intermediate'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
    });

    testWidgets('ExerciseStatsRow renders correct data', (tester) async {
      await tester.pumpLocalizedWidget(
        const ExerciseStatsRow(),
      );

      expect(find.text('30 MIN'), findsOneWidget);
      expect(find.text('130 Cal'), findsOneWidget);
    });


  });
}
