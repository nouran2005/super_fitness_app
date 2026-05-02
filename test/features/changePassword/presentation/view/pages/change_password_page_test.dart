import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view/widgets/change_password_body.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_state.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import '../../../../../helpers/pump_app.dart';

import 'change_password_page_test.mocks.dart';

@GenerateMocks([ChangePasswordCubit])
void main() {
  late MockChangePasswordCubit mockCubit;

  setUp(() async {
    await getIt.reset();
    mockCubit = MockChangePasswordCubit();

    when(mockCubit.oldPasswordController).thenReturn(TextEditingController());
    when(mockCubit.newPasswordController).thenReturn(TextEditingController());
    when(
      mockCubit.confirmPasswordController,
    ).thenReturn(TextEditingController());

    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream<ChangePasswordStates>.empty());
    when(mockCubit.state).thenReturn(
      ChangePasswordStates(changePasswordResource: Resource.initial()),
    );
  });

  group("ChangePasswordBody Widget Tests", () {
    testWidgets('should render form fields correctly', (tester) async {
      await tester.pumpLocalizedWidget(
        BlocProvider<ChangePasswordCubit>.value(
          value: mockCubit,
          child: ChangePasswordBody(cubit: mockCubit),
        ),
      );

      expect(find.text(LocaleKeys.createNewPassword.tr()), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.text(LocaleKeys.done.tr()), findsOneWidget);
    });

    testWidgets('should show validation errors when fields are empty', (
      tester,
    ) async {
      await tester.pumpLocalizedWidget(
        BlocProvider<ChangePasswordCubit>.value(
          value: mockCubit,
          child: ChangePasswordBody(cubit: mockCubit),
        ),
      );

      final doneButton = find.text(LocaleKeys.done.tr());
      await tester.ensureVisible(doneButton);
      await tester.tap(doneButton);
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.field_cant_be_empty.tr()), findsWidgets);
    });
  });
}
