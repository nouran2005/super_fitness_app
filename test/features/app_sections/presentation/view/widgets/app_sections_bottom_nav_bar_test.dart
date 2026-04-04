import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_sections_bottom_nav_bar.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('AppSectionsNavItem', () {
    testWidgets('shows the label when the item is selected', (tester) async {
      await tester.pumpApp(
        Center(
          child: AppSectionsNavItem(
            destination: appSectionDestinations.first,
            isSelected: true,
            onTap: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final label = tester.widget<Text>(
        find.text(appSectionDestinations.first.label),
      );

      expect(label.style?.color, AppColors.primary);
    });

    testWidgets('hides the label and forwards taps when unselected', (
      tester,
    ) async {
      var tapCount = 0;

      await tester.pumpApp(
        Center(
          child: AppSectionsNavItem(
            destination: appSectionDestinations.first,
            isSelected: false,
            onTap: () => tapCount++,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(appSectionDestinations.first.label), findsNothing);

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapCount, 1);
    });
  });

  group('AppSectionsBottomNavBar', () {
    Future<void> pumpBottomNavBar(
      WidgetTester tester, {
      required int currentIndex,
      required ValueChanged<int> onDestinationSelected,
    }) async {
      await tester.pumpApp(
        Scaffold(
          bottomNavigationBar: AppSectionsBottomNavBar(
            destinations: appSectionDestinations,
            currentIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Finder navTapTarget(int index) {
      return find
          .descendant(
            of: find.byType(AppSectionsBottomNavBar),
            matching: find.byType(InkWell),
          )
          .at(index);
    }

    testWidgets('renders all destinations and reports tapped indexes', (
      tester,
    ) async {
      int? selectedIndex;

      await pumpBottomNavBar(
        tester,
        currentIndex: 1,
        onDestinationSelected: (index) => selectedIndex = index,
      );

      expect(
        find.byType(AppSectionsNavItem),
        findsNWidgets(appSectionDestinations.length),
      );
      expect(
        find.byType(SvgPicture),
        findsNWidgets(appSectionDestinations.length),
      );
      expect(find.text(appSectionDestinations[1].label), findsOneWidget);
      expect(find.text(appSectionDestinations.first.label), findsNothing);

      await tester.tap(navTapTarget(3));
      await tester.pumpAndSettle();

      expect(selectedIndex, 3);
    });
  });
}
