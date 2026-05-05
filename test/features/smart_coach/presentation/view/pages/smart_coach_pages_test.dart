import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/pages/smart_coach_chat_page.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';

class MockSmartCoachCubit extends MockCubit<SmartCoachState>
    implements SmartCoachCubit {}

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

void main() {
  late MockSmartCoachCubit mockSmartCoachCubit;
  late MockProfileCubit mockProfileCubit;

  setUpAll(() {
    getIt.allowReassignment = true;
    mockProfileCubit = MockProfileCubit();
    // Register the mock in GetIt so the Page can find it
    getIt.registerSingleton<ProfileCubit>(mockProfileCubit);
  });

  setUp(() {
    mockSmartCoachCubit = MockSmartCoachCubit();
    when(() => mockSmartCoachCubit.state).thenReturn(SmartCoachState.initial());
    when(() => mockProfileCubit.state).thenReturn(ProfileState());
  });

  group('SmartCoachChatPage Tests', () {
    testWidgets('should render SmartCoachChatScreen', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
            BlocProvider<SmartCoachCubit>.value(value: mockSmartCoachCubit),
          ],
          child: MaterialApp(
            home: SmartCoachChatPage(cubit: mockSmartCoachCubit),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
