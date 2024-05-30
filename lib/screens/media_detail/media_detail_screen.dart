import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_body.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';

class MediaDetailScreen extends StatelessWidget {
  final MediaModel media;
  final MediaType mediaType;

  const MediaDetailScreen(
      {super.key, required this.media, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaDetailHeaderImage(
              posterPathMedia: media.posterPath,
            ),
            MediaDetailBody(
              media: media,
              mediaType: mediaType,
            ),
          ],
        ),
      ),
    );
  }
}
