import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MostPopularMovieCard extends StatelessWidget {
  const MostPopularMovieCard({
    super.key,
    required this.popularMovies,
    required this.screenHeight,
  });

  final List<PopularMovieModel> popularMovies;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: TransparentGradientContainer(
            height: screenHeight / 3,
            child: Container(
              color: AppColors.backgroundColor,
              child: Image.network(
                AppStrings.urlImagePoster + popularMovies[0].posterPath,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'tagssssssss do filme',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        )
      ],
    );
  }
}
