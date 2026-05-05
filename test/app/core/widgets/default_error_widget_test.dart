import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/widgets/default_error_widget.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('DefaultErrorWidget', () {
    testWidgets('renders default message and no retry button', (tester) async {
      await tester.pumpLocalizedWidget(const DefaultErrorWidget());

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('renders custom message', (tester) async {
      await tester.pumpLocalizedWidget(
        const DefaultErrorWidget(message: 'Custom Error'),
      );

      expect(find.text('Custom Error'), findsOneWidget);
    });

    testWidgets('renders retry button and triggers callback', (tester) async {
      bool retryPressed = false;
      await tester.pumpLocalizedWidget(
        DefaultErrorWidget(
          onRetry: () {
            retryPressed = true;
          },
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Resend'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(retryPressed, isTrue);
    });
  });
}
