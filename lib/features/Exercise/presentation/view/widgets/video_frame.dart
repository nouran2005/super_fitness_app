import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoFrame extends StatefulWidget {
  final String videoUrl;

  const VideoFrame({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoFrame> createState() => _VideoFrameState();
}

class _VideoFrameState extends State<VideoFrame> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = _convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true, // Enables the FS button in the player
        mute: false,
        showVideoAnnotations: false,
        enableJavaScript: true,
      ),
    );
  }

  String? _convertUrlToId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.host == 'youtu.be') {
      return uri.pathSegments.first;
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }
    return null;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return player;
      },
    );
  }
}
