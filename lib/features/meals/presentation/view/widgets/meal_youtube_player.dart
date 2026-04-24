// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class MealYoutubePlayer extends StatefulWidget {
//   final String youtubeUrl;

//   const MealYoutubePlayer({super.key, required this.youtubeUrl});

//   @override
//   State<MealYoutubePlayer> createState() => _MealYoutubePlayerState();
// }

// class _MealYoutubePlayerState extends State<MealYoutubePlayer> {
//   late YoutubePlayerController _controller;
//   bool _isValid = true;

//   @override
//   void initState() {
//     super.initState();

//     final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);

//     if (videoId == null) {
//       _isValid = false;
//       return;
//     }

//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//         enableCaption: true,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isValid) {
//       return const Text(
//         "Invalid YouTube link",
//         style: TextStyle(color: Colors.white),
//       );
//     }

//     return YoutubePlayer(
//       controller: _controller,
//       showVideoProgressIndicator: true,
//     );
//   }

//   @override
//   void dispose() {
//     if (_isValid) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }
// }
