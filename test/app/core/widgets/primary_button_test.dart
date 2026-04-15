import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/widgets/primary_button.dart';

import '../../../helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PrimaryButton', () {
    testWidgets('renders its label and triggers the callback when enabled', (
      tester,
    ) async {
      var tapCount = 0;

      await tester.pumpLocalizedWidget(
        PrimaryButton(text: 'Continue', onPressed: () => tapCount++),
      );

      expect(find.text('Continue'), findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });

    testWidgets('is disabled when isEnabled is false', (tester) async {
      await tester.pumpLocalizedWidget(
        PrimaryButton(text: 'Continue', isEnabled: false, onPressed: () {}),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('is disabled without a callback and keeps its layout values', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const PrimaryButton(
          text: 'Continue',
          height: 64,
          horizontalPadding: 24,
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ),
      );

      expect(button.onPressed, isNull);
      expect(sizedBox.height, 64);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Padding &&
              widget.padding == const EdgeInsets.symmetric(horizontal: 24),
        ),
        findsOneWidget,
      );
    });
  });
}
