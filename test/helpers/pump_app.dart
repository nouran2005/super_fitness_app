import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/ui_helper/theme/app_theme.dart';

class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return const {
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot password?',
    };
  }
}

extension PumpApp on WidgetTester {
  Future<void> pumpLocalizedWidget(
    Widget child, {
    bool withScaffold = true,
  }) async {
    await pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        path: 'unused',
        assetLoader: const TestAssetLoader(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: AppTheme.lightTheme,
              home: withScaffold ? Scaffold(body: child) : child,
            );
          },
        ),
      ),
    );

    await pumpAndSettle();
  }
}
