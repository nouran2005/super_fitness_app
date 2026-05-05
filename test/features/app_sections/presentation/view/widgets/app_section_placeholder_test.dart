import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_section_placeholder.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('AppSectionPlaceholder', () {
    testWidgets('renders the provided content with the expected styling', (
      tester,
    ) async {
      const title = 'Explore';
      const subtitle =
          'Discover classes, plans, and fresh ideas for your next session.';

      await tester.pumpLocalizedWidget(
        const AppSectionPlaceholder(title: title, subtitle: subtitle),
      );
      await tester.pumpAndSettle();

      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);

      final background = tester.widget<DecoratedBox>(
        find.byWidgetPredicate((widget) {
          if (widget is! DecoratedBox) {
            return false;
          }

          final decoration = widget.decoration;
          return decoration is BoxDecoration && decoration.image != null;
        }),
      );
      final backgroundDecoration = background.decoration as BoxDecoration;

      expect(
        (backgroundDecoration.image!.image as AssetImage).assetName,
        Assets.imagesHomeBackground,
      );

      final gradientContainer = tester.widget<Container>(
        find.byWidgetPredicate((widget) {
          if (widget is! Container) {
            return false;
          }

          final decoration = widget.decoration;
          return decoration is BoxDecoration && decoration.gradient != null;
        }),
      );
      final gradient =
          (gradientContainer.decoration! as BoxDecoration).gradient!
              as LinearGradient;

      expect(gradient.colors, const [
        Color(0xB3000000),
        Color(0xF2000000),
        AppColors.blackColor,
      ]);
    });
  });
}
