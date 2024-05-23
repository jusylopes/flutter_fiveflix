import 'package:flutter/widgets.dart';
import 'package:flutter_fiveflix/models/trailer_model.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerWidget extends StatefulWidget {
  const TrailerWidget({super.key, required this.trailerList});

  final List<TrailerModel> trailerList;

  @override
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  late YoutubePlayerController _controller;
  late final String _trailerKey;

  @override
  void initState() {
    _trailerKey = widget.trailerList[0].key;
    _controller = YoutubePlayerController(
      initialVideoId: _trailerKey,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        isLive: false,
        loop: false,
        forceHD: false,
        showLiveFullscreenButton: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      progressIndicatorColor: AppColors.primaryColor,
      showVideoProgressIndicator: true,
    );
  }
}
