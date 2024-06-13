import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';

class CachedNetworkImageMedia extends StatelessWidget {
  final String url;
  final BoxFit boxFit;

  const CachedNetworkImageMedia(
      {super.key, required this.url, this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
      url: url,
      fit: boxFit,
      loadingBuilder: (context, url) =>
          const FiveflixCircularProgressIndicator(),
      errorBuilder: (context, url, error) => const Icon(
        Icons.error,
        size: 50.0,
      ),
    );
  }
}
