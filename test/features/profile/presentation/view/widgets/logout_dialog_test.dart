import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/logout_dialog.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget buildTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MaterialApp(home: Scaffold(body: LogoutDialog())),
    );
  }

  group('LogoutDialog Widget Tests', () {
    testWidgets('renders dialog with text and buttons', (tester) async {
      await tester.pumpWidget(buildTest());
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.areYouSureToLogout.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.yes.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.no.tr()), findsOneWidget);
    });

    testWidgets('tapping YES returns true', (tester) async {
      bool? result;

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        result = await showDialog<bool>(
                          context: context,
                          builder: (_) => const LogoutDialog(),
                        );
                      },
                      child: const Text('open'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(LocaleKeys.yes.tr()));
      await tester.pumpAndSettle();

      expect(result, true);
    });

    testWidgets('tapping NO returns false', (tester) async {
      bool? result;

      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        result = await showDialog<bool>(
                          context: context,
                          builder: (_) => const LogoutDialog(),
                        );
                      },
                      child: const Text('open'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(LocaleKeys.no.tr()));
      await tester.pumpAndSettle();

      expect(result, false);
    });
  });
}
