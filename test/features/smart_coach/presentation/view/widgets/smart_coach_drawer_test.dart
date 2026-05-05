import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view/widgets/smart_coach_drawer.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_cubit.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/cubit/smart_coach_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSmartCoachCubit extends MockCubit<SmartCoachState>
    implements SmartCoachCubit {}

void main() {
  late MockSmartCoachCubit mockCubit;

  setUp(() {
    mockCubit = MockSmartCoachCubit();
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: BlocProvider<SmartCoachCubit>(
        create: (context) => mockCubit,
        child: const Scaffold(drawer: SmartCoachDrawer(), body: Text('Body')),
      ),
    );
  }

  group('SmartCoachDrawer Widget Tests', () {
    testWidgets('should render "No previous chats" when chat list is empty', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(SmartCoachState.initial());

      await tester.pumpWidget(buildTestWidget());

      // Open the drawer
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.textContaining('no_previous_chats'), findsOneWidget);
    });

    testWidgets('should render chat list when chats are available', (
      tester,
    ) async {
      final tChats = [
        {'id': 1, 'title': 'Chat 1'},
        {'id': 2, 'title': 'Chat 2'},
      ];
      when(() => mockCubit.state).thenReturn(
        SmartCoachState.initial().copyWith(
          chatsResource: Resource.success(tChats),
        ),
      );

      await tester.pumpWidget(buildTestWidget());

      // Open the drawer
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Chat 1'), findsOneWidget);
      expect(find.text('Chat 2'), findsOneWidget);
    });

    testWidgets('should render loading indicator when fetching chats', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        SmartCoachState.initial().copyWith(chatsResource: Resource.loading()),
      );

      await tester.pumpWidget(buildTestWidget());

      // Open the drawer
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pump(); // No need for pumpAndSettle because of indicator

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
