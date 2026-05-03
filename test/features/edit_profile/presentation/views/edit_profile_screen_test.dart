import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/edit_profile_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/edit_profile_body.dart';

import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';

class MockEditProfileCubit extends MockCubit<EditProfileState> implements EditProfileCubit {}

class _FakeEditProfileEvent extends Fake implements GetLoggedUserDataProcessEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(_FakeEditProfileEvent());
  });

  late EditProfileCubit cubit;

  setUp(() {
    cubit = MockEditProfileCubit();
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => cubit.state).thenReturn(EditProfileState(
      getLoggedUserData: Resource.initial(),
    ));
    // onEvent is called in initState — stub it to do nothing
    when(() => cubit.onEvent(any())).thenReturn(null);
    getIt.registerSingleton<EditProfileCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('EditProfileScreen', () {
    testWidgets('renders EditProfileBody correctly', (tester) async {
      final previousOnError = FlutterError.onError;
      FlutterError.onError = (_) {};

      final router = GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(path: '/sign-in', builder: (context, state) => const Scaffold()),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      FlutterError.onError = previousOnError;

      expect(find.byType(EditProfileBody), findsOneWidget);
    });
  });
}
