import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/edit_profile_body.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_selection_tile.dart';

import '../../../../helpers/pump_app.dart';
import 'edit_profile_widgets_test.mocks.dart';

const _tUser = LoggedUserEntity(
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  weight: 80,
  activityLevel: 'level2',
  goal: 'Lose weight',
  photo: '',
);

final _tResponseEntity = LoggedUserDataResponseEntity(
  message: 'success',
  user: _tUser,
);

Future<void> _ignoreOverflow(Future<void> Function() body) async {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('RenderFlex overflowed')) return;
    originalOnError?.call(details);
  };
  try {
    await body();
  } finally {
    FlutterError.onError = originalOnError;
  }
}

Widget _buildBodyUnderTest({
  required MockEditProfileCubit mockCubit,
  required EditProfileState state,
}) {
  return BlocProvider<EditProfileCubit>.value(
    value: mockCubit,
    child: EditProfileBody(
      state: state,
      size: const Size(400, 800),
      horizontalPadding: 24,
      formKey: GlobalKey<FormState>(),
      firstNameController: TextEditingController(
        text: state.updatedUser?.firstName ?? '',
      ),
      lastNameController: TextEditingController(
        text: state.updatedUser?.lastName ?? '',
      ),
      emailController: TextEditingController(
        text: state.updatedUser?.email ?? '',
      ),
      openWeightSheet: () async {},
      openGoalSheet: () async {},
      openActivitySheet: () async {},
    ),
  );
}

@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockCubit;

  setUp(() {
    mockCubit = MockEditProfileCubit();
    when(mockCubit.close()).thenAnswer((_) async {});
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  group('EditProfileBody – loading state', () {
    late EditProfileState loadingState;

    setUp(() {
      loadingState = EditProfileState(getLoggedUserData: Resource.loading());
      when(mockCubit.state).thenReturn(loadingState);
      when(mockCubit.isSaveEnabled).thenReturn(false);
    });

    testWidgets('renders placeholder content while loading', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: loadingState),
            settle: false,
          );
          await tester.pump();
          expect(find.text('Placeholder Name'), findsOneWidget);
        });
      });
    });
  });

  group('EditProfileBody – success state', () {
    late EditProfileState successState;

    setUp(() {
      successState = EditProfileState(
        getLoggedUserData: Resource.success(_tResponseEntity),
        originalUser: _tUser,
        updatedUser: _tUser,
        isFormValid: true,
      );
      when(mockCubit.state).thenReturn(successState);
      when(mockCubit.isSaveEnabled).thenReturn(true);
    });

    testWidgets('renders first name text field with correct value', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.text('John'), findsOneWidget);
        });
      });
    });

    testWidgets('renders last name text field with correct value', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.text('Doe'), findsOneWidget);
        });
      });
    });

    testWidgets('renders email text field with correct value', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.text('john@example.com'), findsOneWidget);
        });
      });
    });

    testWidgets(
      'renders three ProfileSelectionTile widgets (weight/goal/activity)',
      (tester) async {
        await _ignoreOverflow(() async {
          await mockNetworkImagesFor(() async {
            await tester.pumpLocalizedWidget(
              _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
              settle: false,
            );
            await tester.pump();

            expect(find.byType(ProfileSelectionTile), findsNWidgets(3));
          });
        });
      },
    );

    testWidgets('renders Save Changes button', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.text('Save Changes'), findsOneWidget);
        });
      });
    });

    testWidgets('form fields are visible in success state', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.byType(Form), findsOneWidget);
          expect(find.byType(TextFormField), findsWidgets);
        });
      });
    });

    testWidgets('weight tile shows user weight with kg label', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.textContaining('80'), findsOneWidget);
        });
      });
    });

    testWidgets('displays user full name below the avatar', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await tester.pumpLocalizedWidget(
            _buildBodyUnderTest(mockCubit: mockCubit, state: successState),
            settle: false,
          );
          await tester.pump();

          expect(find.text('John Doe'), findsOneWidget);
        });
      });
    });
  });

  group('EditProfileBody – error state', () {
    late EditProfileState errorState;

    setUp(() {
      errorState = EditProfileState(
        getLoggedUserData: Resource.error('Network error'),
      );
      when(mockCubit.state).thenReturn(errorState);
      when(mockCubit.isSaveEnabled).thenReturn(false);
    });

    testWidgets('shows the error message text', (tester) async {
      await _ignoreOverflow(() async {
        await tester.pumpLocalizedWidget(
          _buildBodyUnderTest(mockCubit: mockCubit, state: errorState),
          settle: false,
        );
        await tester.pump();

        expect(find.text('Network error'), findsOneWidget);
      });
    });

    testWidgets('shows a retry button on error', (tester) async {
      await _ignoreOverflow(() async {
        await tester.pumpLocalizedWidget(
          _buildBodyUnderTest(mockCubit: mockCubit, state: errorState),
          settle: false,
        );
        await tester.pump();

        expect(find.text('Retry'), findsOneWidget);
      });
    });

    testWidgets('does not render ProfileSelectionTile in error state', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await tester.pumpLocalizedWidget(
          _buildBodyUnderTest(mockCubit: mockCubit, state: errorState),
          settle: false,
        );
        await tester.pump();

        expect(find.byType(ProfileSelectionTile), findsNothing);
      });
    });
  });
}
