import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_star_rating.dart';

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({
    super.key,
    required this.movie,
  });

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          MediaChipGenre(
            genresMovie: movie.genres,
            wrapAlignment: WrapAlignment.start,
          ),
          const SizedBox(height: 8),
          CustomStarRating(
            voteAverage: movie.voteAverage,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Story Line',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            movie.overview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
