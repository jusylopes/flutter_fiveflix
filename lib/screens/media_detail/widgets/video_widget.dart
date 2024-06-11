import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoWidget extends StatefulWidget {
  final List<TrailerModel> videoList;

  const VideoWidget({super.key, required this.videoList});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.videoList.isNotEmpty) {
      final String videoKey = widget.videoList[0].key;

      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoKey,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showFullscreenButton: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: YoutubePlayer(
          controller: _controller,
          backgroundColor: FiveflixColors.backgroundColor,
          enableFullScreenOnVerticalDrag: false,
        ),
      ),
    );
  }
}
