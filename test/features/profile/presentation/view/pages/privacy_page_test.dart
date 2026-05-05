import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/profile/presentation/view/pages/privacy_page.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

import 'privacy_page_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  late MockProfileCubit profileCubit;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    profileCubit = MockProfileCubit();

    when(profileCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTest() {
    return Builder(
      builder: (context) {
        return BlocProvider<ProfileCubit>.value(
          value: profileCubit,
          child: MaterialApp(locale: const Locale('en'), home: PrivacyPage()),
        );
      },
    );
  }

  testWidgets('renders PrivacyPage loading state', (tester) async {
    when(
      profileCubit.state,
    ).thenReturn(ProfileState(privacy: Resource.loading()));

    await tester.pumpWidget(buildTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders PrivacyPage error state', (tester) async {
    when(profileCubit.state).thenReturn(
      ProfileState(privacy: Resource.error('Failed to load privacy data')),
    );

    await tester.pumpWidget(buildTest());

    expect(find.text('Failed to load privacy data'), findsOneWidget);
  });

  testWidgets(
    'HelpPage displays AuthBlurryBackground with correct properties',
    (tester) async {
      when(
        profileCubit.state,
      ).thenReturn(ProfileState(privacy: Resource.loading()));

      await tester.pumpWidget(buildTest());

      final backgroundFinder = find.byType(AuthBlurryBackground);
      expect(backgroundFinder, findsOneWidget);

      final AuthBlurryBackground background = tester.widget(backgroundFinder);
      expect(background.blurSigmaX, 6);
      expect(background.blurSigmaY, 6);
      expect(background.blurAlpha, 40);
    },
  );

  testWidgets('HelpPage back button has correct icon and color', (
    tester,
  ) async {
    when(
      profileCubit.state,
    ).thenReturn(ProfileState(privacy: Resource.loading()));

    await tester.pumpWidget(buildTest());

    final iconFinder = find.byIcon(Icons.arrow_forward_ios);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.size, 26);
  });
}
