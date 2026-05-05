import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_state.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/presentation/view/pages/profile_page.dart';
import 'package:super_fitness_app/features/profile/presentation/view/widgets/text_list_widget.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_page_test.mocks.dart';

@GenerateMocks([ProfileCubit, LogoutCubit])
void main() {
  late MockProfileCubit profileCubit;
  late MockLogoutCubit logoutCubit;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    profileCubit = MockProfileCubit();
    logoutCubit = MockLogoutCubit();

    getIt.reset();
    getIt.registerFactory<LogoutCubit>(() => logoutCubit);
    getIt.registerFactory<ProfileCubit>(() => profileCubit);

    when(profileCubit.stream).thenAnswer((_) => const Stream.empty());
    when(logoutCubit.stream).thenAnswer((_) => const Stream.empty());

    when(logoutCubit.state).thenReturn(LogoutStates());
  });

  Widget buildTest() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const ProfilePage()),
        GoRoute(
          path: RouteNames.editProfile,
          builder: (context, state) =>
              const Scaffold(body: Text('Edit Profile')),
        ),
        GoRoute(
          path: RouteNames.changePassword,
          builder: (context, state) =>
              const Scaffold(body: Text('Change Password')),
        ),
        GoRoute(
          path: RouteNames.securityPage,
          builder: (context, state) => const Scaffold(body: Text('Security')),
        ),
        GoRoute(
          path: RouteNames.privacyPage,
          builder: (context, state) => const Scaffold(body: Text('Privacy')),
        ),
        GoRoute(
          path: RouteNames.helpPage,
          builder: (context, state) => const Scaffold(body: Text('Help')),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (context, state) => const Scaffold(body: Text('Login')),
        ),
      ],
    );

    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: profileCubit),
              BlocProvider<LogoutCubit>.value(value: logoutCubit),
            ],
            child: MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: const Locale('en'),
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }

  testWidgets('renders ProfilePage basic UI', (tester) async {
    when(profileCubit.state).thenReturn(
      ProfileState(
        profileData: Resource.success(
          ProfileDataModel(
            user: ProfileUserModel(
              firstName: 'John',
              lastName: 'Doe',
              photo: 'https://example.com/photo.png',
            ),
          ),
        ),
        languageCode: 'en',
      ),
    );

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTest());
      await tester.pumpAndSettle();
    });

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(TextListWidget), findsWidgets);
  });

  testWidgets('shows logout dialog on tap', (tester) async {
    when(profileCubit.state).thenReturn(
      ProfileState(
        profileData: Resource.success(
          ProfileDataModel(
            user: ProfileUserModel(
              firstName: 'John',
              lastName: 'Doe',
              photo: 'https://example.com/photo.png',
            ),
          ),
        ),
        languageCode: 'en',
      ),
    );

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTest());
      await tester.pumpAndSettle();
    });
  });
}
