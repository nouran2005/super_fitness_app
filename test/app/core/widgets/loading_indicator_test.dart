import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/app/core/widgets/loading_indicator.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('renders Lottie animation with default properties', (tester) async {
      await tester.pumpLocalizedWidget(const LoadingIndicator(), settle: false);

      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Lottie), findsOneWidget);

      final lottieWidget = tester.widget<Lottie>(find.byType(Lottie));
      expect(lottieWidget.width, 150.0);
      expect(lottieWidget.height, 150.0);
      expect(lottieWidget.fit, BoxFit.contain);
      expect(lottieWidget.repeat, isTrue);
    });

    testWidgets('renders Lottie animation with custom properties', (tester) async {
      await tester.pumpLocalizedWidget(
        const LoadingIndicator(
          size: 200,
          repeat: false,
          fit: BoxFit.cover,
          backgroundColor: Colors.red,
        ),
        settle: false,
      );

      final containerWidget = tester.widget<Container>(
        find.descendant(
          of: find.byType(LoadingIndicator),
          matching: find.byType(Container),
        ).first,
      );
      expect(containerWidget.color, Colors.red);

      final lottieWidget = tester.widget<Lottie>(find.byType(Lottie));
      expect(lottieWidget.width, 200.0);
      expect(lottieWidget.height, 200.0);
      expect(lottieWidget.fit, BoxFit.cover);
      expect(lottieWidget.repeat, isFalse);
    });
  });
}
