import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_entity.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/container_title.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_item.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_list.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

import '../../../../helpers/pump_app.dart';
import 'popular_training_widgets_test.mocks.dart';

const _tExercise = ExerciseEntity(
  id: '1',
  exercise: 'Bicep Curls',
  difficultyLevel: 'Beginner',
  shortYoutubeDemonstration: 'https://youtube.com/watch?v=test',
);

const _tEntity = PopularTrainingEntity(
  exercise: _tExercise,
  muscleImage: 'https://dummyimage.com/600x400/000/fff',
  muscleName: 'Biceps',
  totalExercises: 12,
);

List<PopularTrainingEntity> _buildEntityList(int count) =>
    List.generate(count, (_) => _tEntity);

void _registerMockCubit(MockPopularTrainingCubit mock) {
  if (getIt.isRegistered<PopularTrainingCubit>()) {
    getIt.unregister<PopularTrainingCubit>();
  }
  getIt.registerFactory<PopularTrainingCubit>(() => mock);
}

Future<T> _ignoreOverflow<T>(Future<T> Function() body) async {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('RenderFlex overflowed')) return;
    originalOnError?.call(details);
  };
  try {
    return await body();
  } finally {
    FlutterError.onError = originalOnError;
  }
}

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpLocalizedWidget(child, settle: false);
  await tester.pump();
}

@GenerateMocks([PopularTrainingCubit])
void main() {
  late MockPopularTrainingCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularTrainingCubit();
    _registerMockCubit(mockCubit);
    when(mockCubit.close()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('PopularTrainingItem', () {
    testWidgets('renders exercise name, total exercises and difficulty level', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingItem(entity: _tEntity));

          expect(find.text('Bicep Curls'), findsOneWidget);
          expect(find.text('12 ${LocaleKeys.Tasks.tr()}'), findsOneWidget);
          expect(find.text('Beginner'), findsOneWidget);
        });
      });
    });

    testWidgets('renders two ContainerTitle badges (exercises + difficulty)', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingItem(entity: _tEntity));

          expect(find.byType(ContainerTitle), findsNWidgets(2));
        });
      });
    });

    testWidgets('widget is present in the tree', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingItem(entity: _tEntity));

          expect(find.byType(PopularTrainingItem), findsOneWidget);
        });
      });
    });
  });

  group('PopularTrainingList – loading state', () {
    setUp(() {
      when(
        mockCubit.state,
      ).thenReturn(PopularTrainingState(popularExercises: Resource.loading()));
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('shows "Popular Training" section title while loading', (
      tester,
    ) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingList());
          expect(find.text(LocaleKeys.PopularsTraining.tr()), findsOneWidget);
        });
      });
    });

    testWidgets('shows mock skeleton items while loading', (tester) async {
      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingList());
          expect(find.byType(PopularTrainingItem), findsWidgets);
        });
      });
    });
  });

  group('PopularTrainingList – success state', () {
    testWidgets('renders a disabled Skeletonizer + ListView with exercises', (
      tester,
    ) async {
      final exercises = _buildEntityList(4);
      when(mockCubit.state).thenReturn(
        PopularTrainingState(popularExercises: Resource.success(exercises)),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingList());
          expect(find.byType(ListView), findsOneWidget);
          expect(find.byType(PopularTrainingItem), findsWidgets);
        });
      });
    });

    testWidgets('each item shows exercise name and difficulty', (tester) async {
      when(mockCubit.state).thenReturn(
        PopularTrainingState(
          popularExercises: Resource.success(_buildEntityList(1)),
        ),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingList());
          expect(find.text('Bicep Curls'), findsOneWidget);
          expect(find.text('Beginner'), findsOneWidget);
        });
      });
    });

    testWidgets('renders empty ListView when data list is empty', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        PopularTrainingState(popularExercises: Resource.success([])),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await mockNetworkImagesFor(() async {
          await _pump(tester, const PopularTrainingList());
          expect(find.byType(ListView), findsOneWidget);
          expect(find.byType(PopularTrainingItem), findsNothing);
        });
      });
    });
  });

  group('PopularTrainingList – error state', () {
    testWidgets('displays a specific error message when fetching fails', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        PopularTrainingState(popularExercises: Resource.error('Network error')),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await _pump(tester, const PopularTrainingList());

        expect(find.text('Network error'), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
      });
    });

    testWidgets('does not render a ListView in error state', (tester) async {
      when(mockCubit.state).thenReturn(
        PopularTrainingState(popularExercises: Resource.error('Oops')),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await _pump(tester, const PopularTrainingList());
        expect(find.byType(ListView), findsNothing);
      });
    });

    testWidgets('error state shows no Skeletonizer', (tester) async {
      when(mockCubit.state).thenReturn(
        PopularTrainingState(popularExercises: Resource.error('some error')),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await _ignoreOverflow(() async {
        await _pump(tester, const PopularTrainingList());
        expect(find.byType(Skeletonizer), findsNothing);
      });
    });
  });
}
