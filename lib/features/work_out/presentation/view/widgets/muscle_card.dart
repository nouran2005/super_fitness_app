import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_entity.dart';

class MuscleCard extends StatelessWidget {
  final MuscleEntity muscle;
  const MuscleCard({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //context.push(RouteNames.muscleDetails, extra: {'id': muscle.id, 'name': muscle.name});
        //print('Tapped on muscle: ${muscle.name} with id: ${muscle.id}');
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              muscle.image ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white54,
                    size: 40,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[700]!,
                  child: Container(color: Colors.white),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withAlpha(150), Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  muscle.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
