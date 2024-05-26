import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/cached_network_image.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MediaDetailHeaderImage extends StatelessWidget {
  const MediaDetailHeaderImage({
    super.key,
    required this.posterPathMedia,
  });

  final String posterPathMedia;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return TransparentGradientContainer(
      height: screenHeight / 2.0,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
        child: CachedNetworkImageMedia(
          url: FiveflixStrings.urlImagePosterOriginal + posterPathMedia,
        ),
      ),
    );
  }
}
