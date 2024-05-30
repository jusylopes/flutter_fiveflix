import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class TrailerWidget extends StatefulWidget {
  final List<TrailerModel> trailerList;

  const TrailerWidget({super.key, required this.trailerList});

  @override
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.trailerList.isNotEmpty) {
      final String trailerKey = widget.trailerList[0].key;

      _controller = YoutubePlayerController(
        initialVideoId: trailerKey,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          isLive: false,
          loop: false,
          forceHD: false,
          showLiveFullscreenButton: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.trailerList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: YoutubePlayer(
          controller: _controller,
          progressIndicatorColor: FiveflixColors.primaryColor,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
