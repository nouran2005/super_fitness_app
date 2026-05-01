import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/smart_coach_chat_screen.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/smart_coach_start_screen.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/chat_bubble.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/typing_indicator.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';

class MockSmartCoachCubit extends MockCubit<SmartCoachState>
    implements SmartCoachCubit {}

class SmartCoachEventFake extends Fake implements SmartCoachEvent {}

void main() {
  late MockSmartCoachCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(SmartCoachEventFake());
  });

  setUp(() {
    mockCubit = MockSmartCoachCubit();
    when(() => mockCubit.state).thenReturn(SmartCoachState.initial());
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<SmartCoachCubit>.value(value: mockCubit, child: child),
    );
  }

  group('SmartCoachStartScreen Widget Tests', () {
    testWidgets('should render start screen elements', (tester) async {
      await tester.pumpWidget(buildTestWidget(const SmartCoachStartScreen()));
      await tester.pump();

      expect(find.textContaining('smart_coach'), findsOneWidget);
      expect(find.textContaining('get_started'), findsOneWidget);
    });
  });

  group('SmartCoachChatScreen Widget Tests', () {
    testWidgets('should render chat screen elements', (tester) async {
      await tester.pumpWidget(buildTestWidget(const SmartCoachChatScreen()));
      await tester.pump();

      expect(find.textContaining('smart_coach'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display messages from state', (tester) async {
      final tMessages = [
        {'role': 'user', 'content': 'Hello', 'isError': false},
        {'role': 'bot', 'content': 'Hi!', 'isError': false},
      ];
      when(() => mockCubit.state).thenReturn(
        SmartCoachState.initial().copyWith(
          messagesResource: Resource.success(tMessages),
        ),
      );

      await tester.pumpWidget(buildTestWidget(const SmartCoachChatScreen()));
      await tester.pump();

      expect(find.byType(ChatBubble), findsNWidgets(2));
      expect(find.text('Hello'), findsOneWidget);
      expect(find.text('Hi!'), findsOneWidget);
    });

    testWidgets(
      'should display TypingIndicator when isSendingMessage is true',
      (tester) async {
        when(() => mockCubit.state).thenReturn(
          SmartCoachState.initial().copyWith(
            isSendingMessage: true,
            messagesResource: Resource.success([]),
          ),
        );

        await tester.pumpWidget(buildTestWidget(const SmartCoachChatScreen()));
        await tester.pump();

        expect(find.byType(TypingIndicator), findsOneWidget);
      },
    );

    testWidgets('should display quota error message correctly', (tester) async {
      final tMessages = [
        {'role': 'user', 'content': 'hi', 'isError': false},
        {'role': 'bot', 'content': '⚠️ Quota reached', 'isError': true},
      ];
      when(() => mockCubit.state).thenReturn(
        SmartCoachState.initial().copyWith(
          messagesResource: Resource.success(tMessages),
        ),
      );

      await tester.pumpWidget(buildTestWidget(const SmartCoachChatScreen()));
      await tester.pump();

      expect(find.text('⚠️ Quota reached'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('⚠️ Quota reached'));
      expect(textWidget.style?.color, Colors.white);
    });

    testWidgets('should call SendMessage when send button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(const SmartCoachChatScreen()));
      await tester.pump();

      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      await tester.enterText(textFieldFinder, 'Test message');
      await tester.pump();

      final sendButtonFinder = find.byIcon(Icons.send);
      expect(sendButtonFinder, findsOneWidget);

      await tester.tap(sendButtonFinder);
      await tester.pump();

      verify(() => mockCubit.doEvent(any(that: isA<SendMessage>()))).called(1);
    });
  });
}
