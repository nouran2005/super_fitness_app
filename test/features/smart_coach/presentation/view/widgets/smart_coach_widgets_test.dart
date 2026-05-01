import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/chat_bubble.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/typing_indicator.dart';

void main() {
  group('ChatBubble Widget Tests', () {
    testWidgets('should display user message correctly', (tester) async {
      const message = 'Hello from user';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ChatBubble(message: message, isUser: true)),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.smart_toy), findsNothing);
    });

    testWidgets('should display bot message correctly', (tester) async {
      const message = 'Hello from bot';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ChatBubble(message: message, isUser: false)),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byIcon(Icons.smart_toy), findsOneWidget);
      expect(find.byIcon(Icons.person), findsNothing);
    });

    testWidgets('should display error message with red text', (tester) async {
      const message = 'Error message';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ChatBubble(message: message, isUser: false, isError: true),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(message));
      expect(textWidget.style?.color, Colors.redAccent);
    });
  });

  group('TypingIndicator Widget Tests', () {
    testWidgets('should display typing indicator with bot icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TypingIndicator())),
      );

      expect(find.byIcon(Icons.smart_toy), findsOneWidget);
      // It should have 3 dots
      expect(find.byType(Container), findsAtLeastNWidgets(5));
    });

    testWidgets('should animate dots', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: TypingIndicator())),
      );

      final firstOpacity = tester
          .widget<Opacity>(find.byType(Opacity).first)
          .opacity;

      await tester.pump(const Duration(milliseconds: 200));

      final secondOpacity = tester
          .widget<Opacity>(find.byType(Opacity).first)
          .opacity;

      expect(firstOpacity, isNot(equals(secondOpacity)));
    });
  });
}
