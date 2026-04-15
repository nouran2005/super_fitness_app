import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_text_link.dart';
import 'package:super_fitness_app/app/core/widgets/form_fields/custom_form_field.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:super_fitness_app/features/signin/presentation/view/widgets/signin_body.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';

import '../../../../../helpers/pump_app.dart';

class MockSigninUseCase extends Mock implements SigninUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SigninBody', () {
    late SigninCubit cubit;

    setUp(() {
      cubit = SigninCubit(signinUseCase: MockSigninUseCase());
    });

    tearDown(() async {
      await cubit.close();
    });

    testWidgets('renders the expected sign in content', (tester) async {
      await tester.pumpLocalizedWidget(SigninBody(cubit: cubit));

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(GlassBlurContainer), findsOneWidget);
      expect(find.byType(CustomTextFormField), findsNWidgets(2));
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.text('Hey There'), findsOneWidget);
      expect(find.text('WELCOME BACK'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Dont have an account yet ?'), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is AuthTextLink && widget.text.contains('Forgot password'),
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is AuthTextLink && widget.text == 'Register',
        ),
        findsOneWidget,
      );

      final images = tester.widgetList<Image>(find.byType(Image)).toList();
      final iconImage = images
          .map((image) => image.image)
          .whereType<AssetImage>()
          .firstWhere((provider) => provider.assetName == Assets.appIcon);

      expect(iconImage.assetName, Assets.appIcon);
    });

    testWidgets('configures the email and password form fields correctly', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(SigninBody(cubit: cubit));

      final fields = tester
          .widgetList<EditableText>(find.byType(EditableText))
          .toList();

      expect(fields, hasLength(2));
      expect(fields.first.keyboardType, TextInputType.emailAddress);
      expect(fields.first.obscureText, isFalse);
      expect(fields.last.obscureText, isTrue);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      final signInButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(signInButton.onPressed, isNotNull);
    });

    testWidgets('reveals the password when the visibility icon is tapped', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(SigninBody(cubit: cubit));

      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      final fields = tester
          .widgetList<EditableText>(find.byType(EditableText))
          .toList();

      expect(fields.last.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });
}
