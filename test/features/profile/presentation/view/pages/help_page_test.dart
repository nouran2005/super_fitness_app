import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/profile/presentation/view/pages/help_page.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:go_router/go_router.dart';

import 'help_page_test.mocks.dart';

class MockGoRouter extends Mock implements GoRouter {}

@GenerateMocks([ProfileCubit])
void main() {
  late MockProfileCubit profileCubit;
  late StreamController<ProfileState> stateController;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    profileCubit = MockProfileCubit();
    stateController = StreamController<ProfileState>.broadcast();

    when(profileCubit.stream).thenAnswer((_) => stateController.stream);
    when(profileCubit.state).thenReturn(ProfileState());
  });

  tearDown(() {
    stateController.close();
  });

  Widget buildTest({Widget? child}) {
    return BlocProvider<ProfileCubit>.value(
      value: profileCubit,
      child: MaterialApp(locale: const Locale('en'), home: child ?? HelpPage()),
    );
  }

  testWidgets('renders HelpPage loading state', (tester) async {
    when(profileCubit.state).thenReturn(ProfileState(help: Resource.loading()));

    await tester.pumpWidget(buildTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Center), findsWidgets);
  });

  testWidgets('renders HelpPage error state with custom message', (
    tester,
  ) async {
    when(
      profileCubit.state,
    ).thenReturn(ProfileState(help: Resource.error('Failed to load help')));

    await tester.pumpWidget(buildTest());

    expect(find.text('Failed to load help'), findsOneWidget);
  });

  testWidgets(
    'HelpPage displays AuthBlurryBackground with correct properties',
    (tester) async {
      when(
        profileCubit.state,
      ).thenReturn(ProfileState(help: Resource.loading()));

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
    when(profileCubit.state).thenReturn(ProfileState(help: Resource.loading()));

    await tester.pumpWidget(buildTest());

    final iconFinder = find.byIcon(Icons.arrow_forward_ios);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.size, 26);
  });
}
