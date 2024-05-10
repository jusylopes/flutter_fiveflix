import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MostPopularMovieCard extends StatelessWidget {
  const MostPopularMovieCard({
    super.key,
    required this.posterPathMovie,
    required this.genresMovie,
    required this.nameMovie,
  });

  final String posterPathMovie;
  final List<Genre> genresMovie;

  final String nameMovie;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: TransparentGradientContainer(
            height: screenHeight / 2.4,
            child: Container(
              color: AppColors.backgroundColor,
              child: Image.network(
                AppStrings.urlImagePoster + posterPathMovie,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Chip(
              label: Text(
                'Most popular',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              backgroundColor: AppColors.primaryColor,
              side: const BorderSide(
                width: 0,
                color: AppColors.primaryColor,
              ),
            ),
            MediaChipGenre(
              genresMovie: genresMovie,
              wrapAlignment: WrapAlignment.center,
            ),
            const SizedBox(height: 25),
          ],
        )
      ],
    );
  }
}
