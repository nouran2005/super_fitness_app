import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_card.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  testWidgets('MuscleCard displays name and handles tap', (tester) async {
    final muscle = MuscleEntity(id: '1', name: 'Biceps', image: 'url');
    bool tapped = false;

    await tester.pumpLocalizedWidget(
      Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          children: [MuscleCard(muscle: muscle)],
        ),
      ),
      withScaffold: false,
    );

    expect(find.text('Biceps'), findsOneWidget);

    // Test interaction (card has a GestureDetector)
    await tester.tap(find.byType(MuscleCard));
    await tester.pump();

    // Note: Since navigation is commented out in MuscleCard,
    // we can't test actual navigation yet, but we verified the widget renders.
  });

  testWidgets('MuscleCard shows error icon when image fails', (tester) async {
    final muscle = MuscleEntity(id: '1', name: 'Biceps', image: '');

    await tester.pumpLocalizedWidget(
      Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          children: [MuscleCard(muscle: muscle)],
        ),
      ),
      withScaffold: false,
    );

    // Image errorBuilder should render Icons.broken_image_outlined
    // We pump to allow potential image error cycle
    await tester.pump();

    // In unit tests, network images fail by default if not mocked.
    // The card has an errorBuilder that returns Icons.broken_image_outlined.
    expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);
  });
}
