import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/upcoming_feature_dialog.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('UpcomingFeatureDialog', () {
    testWidgets('renders AlertDialog with feature name', (tester) async {
      await tester.pumpLocalizedWidget(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => UpcomingFeatureDialog.show(context, 'yoga'),
            child: const Text('Open'),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
      expect(find.text('Upcoming Feature'), findsOneWidget);
    });

    testWidgets('closes when Got it is tapped', (tester) async {
      await tester.pumpLocalizedWidget(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => UpcomingFeatureDialog.show(context, 'nutrition'),
            child: const Text('Open'),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.text('Got it!'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
