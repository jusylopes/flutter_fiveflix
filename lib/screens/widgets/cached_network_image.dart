import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';

class CachedNetworkImageMedia extends StatelessWidget {
  final String url;
  final BoxFit boxFit;

  const CachedNetworkImageMedia(
      {super.key, required this.url, this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: boxFit,
      placeholder: (context, url) => const FiveflixCircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 50.0,
      ),
    );
  }
}
