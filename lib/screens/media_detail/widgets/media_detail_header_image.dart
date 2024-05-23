import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

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
      child: Container(
        color: AppColors.backgroundColor,
        child: CachedNetworkImage(
          imageUrl: AppStrings.urlImagePosterOriginal + posterPathMedia,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          colorBlendMode: BlendMode.modulate,
          placeholder: (context, url) => CircularProgressIndicatorApp(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
