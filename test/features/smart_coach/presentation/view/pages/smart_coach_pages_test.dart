import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/pages/smart_coach_chat_page.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';

class MockSmartCoachCubit extends MockCubit<SmartCoachState>
    implements SmartCoachCubit {}

void main() {
  late MockSmartCoachCubit mockCubit;

  setUp(() {
    mockCubit = MockSmartCoachCubit();
    // Default state
    when(() => mockCubit.state).thenReturn(SmartCoachState.initial());
  });

  group('SmartCoachChatPage Tests', () {
    testWidgets('should render SmartCoachChatScreen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: SmartCoachChatPage(cubit: mockCubit)),
      );

      // Verify that SmartCoachChatScreen (which contains a TextField or similar) is rendered
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
