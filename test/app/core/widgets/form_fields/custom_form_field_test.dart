import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CustomTextFormField', () {
    testWidgets('renders hint text, prefix icon, and forwards input changes', (
      tester,
    ) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      String? latestValue;

      await tester.pumpLocalizedWidget(
        CustomTextFormField(
          controller: controller,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.mail_outline_rounded),
          onChanged: (value) => latestValue = value,
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline_rounded), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'user@example.com');
      await tester.pumpAndSettle();

      final field = tester.widget<EditableText>(find.byType(EditableText));

      expect(controller.text, 'user@example.com');
      expect(latestValue, 'user@example.com');
      expect(field.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('shows a password toggle and changes obscureText when tapped', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const CustomTextFormField(
          hintText: 'Password',
          obscureText: true,
          prefixIcon: Icon(Icons.lock_outline_rounded),
        ),
      );

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      var field = tester.widget<EditableText>(find.byType(EditableText));
      expect(field.obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      field = tester.widget<EditableText>(find.byType(EditableText));

      expect(field.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('does not show a visibility toggle for a normal field', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const CustomTextFormField(hintText: 'Name'),
      );

      expect(find.byType(IconButton), findsNothing);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
