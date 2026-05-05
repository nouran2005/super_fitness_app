import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/widgets/empty_data_widget.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('EmptyDataWidget', () {
    testWidgets('renders default message and icon', (tester) async {
      await tester.pumpLocalizedWidget(const EmptyDataWidget());

      expect(find.text('No data found'), findsOneWidget);
      expect(find.byIcon(Icons.folder_open_outlined), findsOneWidget);
      expect(
        find.text('Try adjusting your filters or check back later.'),
        findsOneWidget,
      );
    });

    testWidgets('renders custom message and icon', (tester) async {
      await tester.pumpLocalizedWidget(
        const EmptyDataWidget(message: 'Custom Message', icon: Icons.error),
      );

      expect(find.text('Custom Message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
