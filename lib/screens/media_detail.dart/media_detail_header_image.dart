import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MediaDetailHeaderImage extends StatelessWidget {
  const MediaDetailHeaderImage({
    super.key, required this.posterPathMedia,
  });
 
  final String posterPathMedia;

  @override
  Widget build(BuildContext context) {
   double screenHeight = MediaQuery.of(context).size.height;
   
    return TransparentGradientContainer(
            height: screenHeight / 2.0,
            child: Container(
              color: AppColors.backgroundColor,
              child: Image.network(
                AppStrings.urlImagePoster + posterPathMedia,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          );
  }
}
