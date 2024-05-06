import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/movie_detail/media_detail_body.dart';
import 'package:flutter_fiveflix/screens/movie_detail/media_detail_header_image.dart';

class MediaDetailScreen extends StatelessWidget {
  const MediaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: const Column(
        children: [
          MediaDetailHeaderImage(),
          MediaDetailBody(),
        ],
      ),
    );
  }
}
