import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_states.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_states.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'app_start_page_test.mocks.dart';

@GenerateMocks([AppCubit, SigninCubit])
void main() {
  late MockAppCubit mockCubit;

  setUp(() async {
    await getIt.reset();
    mockCubit = MockAppCubit();
    final mockSigninCubit = MockSigninCubit();
    getIt.registerSingleton<AppCubit>(mockCubit);
    getIt.registerSingleton<SigninCubit>(mockSigninCubit);

    // Stub SigninCubit state to avoid null errors during build
    when(
      mockSigninCubit.state,
    ).thenReturn(SigninStates(loginResource: Resource.initial()));
    when(mockSigninCubit.stream).thenAnswer((_) => Stream.empty());
    when(mockSigninCubit.emailController).thenReturn(TextEditingController());
    when(
      mockSigninCubit.passwordController,
    ).thenReturn(TextEditingController());
  });

  tearDown(() {
    mockCubit.close();
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>.value(value: mockCubit),
          BlocProvider<AppSectionsCubit>(create: (_) => AppSectionsCubit()),
        ],
        child: const AppStartPage(),
      ),
    );
  }

  group('AppStartPage Widget Test', () {
    testWidgets('shows loading widget when loading', (tester) async {
      when(
        mockCubit.state,
      ).thenReturn(AppState(authResource: Resource.loading()));
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(AppState(authResource: Resource.loading())),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('shows OnboardingPage when first time user', (tester) async {
      when(mockCubit.state).thenReturn(
        AppState(authResource: Resource.success(AppAuthStatus.onboarding)),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          AppState(authResource: Resource.success(AppAuthStatus.onboarding)),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('shows HomePage when NOT first time user', (tester) async {
      when(mockCubit.state).thenReturn(
        AppState(authResource: Resource.success(AppAuthStatus.authenticated)),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          AppState(authResource: Resource.success(AppAuthStatus.authenticated)),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(AppSectionsView), findsOneWidget);
    });

    testWidgets('shows SigninPage when unauthenticated', (tester) async {
      when(mockCubit.state).thenReturn(
        AppState(authResource: Resource.success(AppAuthStatus.unauthenticated)),
      );
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          AppState(
            authResource: Resource.success(AppAuthStatus.unauthenticated),
          ),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(SigninPage), findsOneWidget);
    });
  });
}
