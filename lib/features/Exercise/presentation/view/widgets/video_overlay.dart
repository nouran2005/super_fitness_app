import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/video_frame.dart';

class VideoOverlay extends StatelessWidget {
  final String videoUrl;
  final String title;
  final VoidCallback onClose;

  const VideoOverlay({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.95),
        child: Stack(
          children: [
            // Close Button
            Positioned(
              top: padding.top + 20,
              right: 20,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ),
            // Video Player
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppStyles.font30WhiteSemiBold.copyWith(
                        fontSize: size.width * 0.06,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: VideoFrame(videoUrl: videoUrl),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Tap (X) to return to exercises',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
