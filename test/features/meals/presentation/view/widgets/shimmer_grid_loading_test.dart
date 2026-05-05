import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_fitness_app/features/meals/presentation/view/widgets/shimmer_grid_loading.dart';

void main() {
  group('ShimmerGridLoading Widget Test', () {
    testWidgets('should render shimmer grid correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShimmerGridLoading())),
      );

      await tester.pump();

      expect(find.byType(ShimmerGridLoading), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should have correct grid structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShimmerGridLoading())),
      );

      await tester.pump();

      final grid = tester.widget<GridView>(find.byType(GridView));

      expect(grid.padding, const EdgeInsets.all(16));
    });
  });
}
