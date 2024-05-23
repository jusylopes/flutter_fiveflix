import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';

class CachedNetworkImageMedia extends StatelessWidget {
  const CachedNetworkImageMedia(
      {super.key, required this.url, this.boxFit = BoxFit.cover});

  final String url;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: boxFit,
      filterQuality: FilterQuality.low,
      placeholder: (context, url) => const CircularProgressIndicatorApp(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
