import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/edit_profile_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/edit_profile_body.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/profile_selection_tile.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/weight_edit_screen.dart';

import '../../../../../helpers/pump_app.dart';

class MockEditProfileCubit extends MockCubit<EditProfileState>
    implements EditProfileCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockEditProfileCubit mockCubit;

  const tUser = LoggedUserEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@gmail.com',
    weight: 75,
    goal: 'loseWeight',
    activityLevel: 'beginner',
  );

  setUp(() {
    mockCubit = MockEditProfileCubit();
    when(() => mockCubit.state).thenReturn(
      EditProfileState(
        getLoggedUserData: Resource.initial(),
        updatedUser: tUser,
        originalUser: tUser,
      ),
    );
    when(() => mockCubit.isSaveEnabled).thenReturn(true);

    getIt.registerSingleton<EditProfileCubit>(mockCubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('EditProfileScreen', () {
    testWidgets('renders EditProfileBody when state is success', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(const EditProfileScreen());
        await tester.pump();
      });

      expect(find.byType(EditProfileBody), findsOneWidget);
      expect(find.textContaining('John'), findsOneWidget);
      expect(find.textContaining('Doe'), findsOneWidget);
    });

    testWidgets('renders loading state correctly', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      when(() => mockCubit.state).thenReturn(
        EditProfileState(
          getLoggedUserData: Resource.loading(),
          updatedUser: null,
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          const EditProfileScreen(),
          settle: false,
        );
      });

      expect(find.text('Placeholder Name'), findsOneWidget);
    });

    testWidgets('renders error state correctly', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      const errorMessage = 'Network Error';
      when(() => mockCubit.state).thenReturn(
        EditProfileState(
          getLoggedUserData: Resource.error(errorMessage),
          updatedUser: null,
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(const EditProfileScreen());
      });

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('tapping on weight tile opens weight sheet', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(const EditProfileScreen());
      });

      final weightTile = find.byType(ProfileSelectionTile).at(0);
      await tester.ensureVisible(weightTile);
      await tester.tap(weightTile);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(WeightEditScreen), findsOneWidget);
    });
  });
}
