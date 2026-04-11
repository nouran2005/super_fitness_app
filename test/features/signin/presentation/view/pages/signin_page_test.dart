import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';
import 'package:super_fitness_app/features/signin/presentation/view/widgets/signin_body.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';

import '../../../../../helpers/pump_app.dart';

class MockSigninUseCase extends Mock implements SigninUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SigninCubit cubit;

  setUp(() {
    cubit = SigninCubit(signinUseCase: MockSigninUseCase());
    getIt.registerSingleton<SigninCubit>(cubit);
  });

  tearDown(() async {
    await cubit.close();
    await getIt.reset();
  });

  group('SigninPage', () {
    testWidgets('composes the auth background and sign in body', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(const SigninPage(), withScaffold: false);

      expect(find.byType(AuthBlurryBackground), findsOneWidget);
      expect(find.byType(SigninBody), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);

      final background = tester.widget<AuthBlurryBackground>(
        find.byType(AuthBlurryBackground),
      );

      expect(background.widget, isA<SigninBody>());
    });

    testWidgets('uses the default auth background image', (tester) async {
      await tester.pumpLocalizedWidget(const SigninPage(), withScaffold: false);

      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      final backgroundImage = images
          .map((image) => image.image)
          .whereType<AssetImage>()
          .firstWhere(
            (provider) => provider.assetName == Assets.imagesAuthBackground2,
          );

      expect(backgroundImage.assetName, Assets.imagesAuthBackground2);
    });
  });
}
