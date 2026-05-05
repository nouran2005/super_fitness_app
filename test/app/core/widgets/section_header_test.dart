import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/widgets/section_header.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('SectionHeader', () {
    testWidgets('renders title and seeAll by default', (tester) async {
      var seeAllTapped = false;
      await tester.pumpLocalizedWidget(
        SectionHeader(
          title: 'My Section',
          onSeeAllTap: () {
            seeAllTapped = true;
          },
        ),
      );

      expect(find.text('My Section'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);

      await tester.tap(find.text('See All'));
      await tester.pumpAndSettle();

      expect(seeAllTapped, isTrue);
    });

    testWidgets('hides seeAll when showSeeAll is false', (tester) async {
      await tester.pumpLocalizedWidget(
        const SectionHeader(title: 'My Section', showSeeAll: false),
      );

      expect(find.text('My Section'), findsOneWidget);
      expect(find.text('See All'), findsNothing);
    });
  });
}
