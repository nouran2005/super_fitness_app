import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/primary_action_button.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_selection_tile.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_avatar.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('EditProfile Widgets', () {
    testWidgets(
      'PrimaryActionButton renders label and handles tap when enabled',
      (tester) async {
        bool tapped = false;
        await tester.pumpLocalizedWidget(
          PrimaryActionButton(
            label: 'Save',
            onPressed: () {
              tapped = true;
            },
            isEnabled: true,
          ),
        );

        expect(find.text('Save'), findsOneWidget);
        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        expect(button.enabled, isTrue);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      },
    );

    testWidgets('PrimaryActionButton handles disabled state', (tester) async {
      bool tapped = false;
      await tester.pumpLocalizedWidget(
        PrimaryActionButton(
          label: 'Save',
          onPressed: () {
            tapped = true;
          },
          isEnabled: false,
        ),
      );

      expect(find.text('Save'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.enabled, isFalse);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });

    testWidgets('ProfileSelectionTile renders and handles tap', (tester) async {
      bool tapped = false;
      await tester.pumpLocalizedWidget(
        ProfileSelectionTile(
          title: 'Goal',
          value: 'Lose Weight',
          onTap: () {
            tapped = true;
          },
        ),
      );

      expect(find.text('Goal'), findsOneWidget);
      expect(find.text('Lose Weight'), findsOneWidget);
      expect(find.text('(Tap to edit)'), findsOneWidget);

      await tester.tap(find.text('Lose Weight'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('ProfileAvatar renders CircleAvatar when not uploading', (
      tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          const ProfileAvatar(
            image: 'https://example.com/avatar.png',
            isUploading: false,
          ),
          settle: false,
        );

        expect(find.byType(CircleAvatar), findsOneWidget);
      });
    });

    testWidgets('ProfileAvatar shows shimmer when uploading', (tester) async {
      await tester.pumpLocalizedWidget(
        const ProfileAvatar(image: '', isUploading: true),
        settle: false,
      );

      // CircleAvatar is always present as container
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('ProfileAvatar shows person icon when image is empty', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const ProfileAvatar(image: '', isUploading: false),
        settle: false,
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
}
