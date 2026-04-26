import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_states.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_states.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'app_start_page_test.mocks.dart';

import '../../../../helpers/pump_app.dart';

@GenerateMocks([
  AppCubit,
  SigninCubit,
  WorkOutCubit,
  RcToDayCubit,
  PopularTrainingCubit,
])
void main() {
  late MockAppCubit mockCubit;
  late MockSigninCubit mockSigninCubit;
  late MockWorkOutCubit mockWorkOutCubit;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    await getIt.reset();
    mockCubit = MockAppCubit();
    mockSigninCubit = MockSigninCubit();
    mockWorkOutCubit = MockWorkOutCubit();
    final mockRcToDayCubit = MockRcToDayCubit();

    getIt.registerSingleton<AppCubit>(mockCubit);
    getIt.registerSingleton<SigninCubit>(mockSigninCubit);
    getIt.registerSingleton<WorkOutCubit>(mockWorkOutCubit);
    getIt.registerSingleton<RcToDayCubit>(mockRcToDayCubit);
    final mockPopularTrainingCubit = MockPopularTrainingCubit();
    getIt.registerSingleton<PopularTrainingCubit>(mockPopularTrainingCubit);

    // Default stubs
    when(
      mockCubit.state,
    ).thenReturn(AppState(authResource: Resource.initial()));
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.doIntent(any)).thenReturn(null);
    when(mockCubit.close()).thenAnswer((_) async {});

    // Stub RcToDayCubit state
    when(
      mockRcToDayCubit.state,
    ).thenReturn(RcToDayStates(recommendationResource: Resource.initial()));
    when(mockRcToDayCubit.stream).thenAnswer((_) => Stream.empty());

    when(
      mockSigninCubit.state,
    ).thenReturn(SigninStates(loginResource: Resource.initial()));
    when(mockSigninCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockSigninCubit.emailController).thenReturn(TextEditingController());
    when(
      mockSigninCubit.passwordController,
    ).thenReturn(TextEditingController());
    when(mockSigninCubit.close()).thenAnswer((_) async {});

    when(mockWorkOutCubit.state).thenReturn(WorkOutStates());
    when(mockWorkOutCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockWorkOutCubit.close()).thenAnswer((_) async {});

    // Stub PopularTrainingCubit state
    when(
      mockPopularTrainingCubit.state,
    ).thenReturn(PopularTrainingState(popularExercises: Resource.initial()));
    when(mockPopularTrainingCubit.stream).thenAnswer((_) => Stream.empty());
    when(mockPopularTrainingCubit.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    getIt.reset();
  });

  group('AppStartPage Widget Test', () {
    testWidgets('shows loading widget when loading', (tester) async {
      when(
        mockCubit.state,
      ).thenReturn(AppState(authResource: Resource.loading()));

      await tester.pumpLocalizedWidget(
        const AppStartPage(),
        withScaffold: false,
        settle: false,
      );

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('shows OnboardingPage when first time user', (tester) async {
      when(mockCubit.state).thenReturn(
        AppState(authResource: Resource.success(AppAuthStatus.onboarding)),
      );

      await tester.pumpLocalizedWidget(
        const AppStartPage(),
        withScaffold: false,
        settle: false,
      );
      await tester.pump();

      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('shows SigninPage when unauthenticated', (tester) async {
      when(mockCubit.state).thenReturn(
        AppState(authResource: Resource.success(AppAuthStatus.unauthenticated)),
      );

      await tester.pumpLocalizedWidget(
        const AppStartPage(),
        withScaffold: false,
        settle: false,
      );
      await tester.pump();

      expect(find.byType(SigninPage), findsOneWidget);
    });
  });
}
