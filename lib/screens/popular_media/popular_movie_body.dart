import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/popular_media/most_popular_movie_card.dart';
import 'package:flutter_fiveflix/screens/widgets/card_media.dart';

class PopularMoviebody extends StatelessWidget {
  const PopularMoviebody({
    super.key,
    required this.popularMovies,
  });

  final List<MovieModel> popularMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MostPopularMovieCard(
            nameMovie: popularMovies[0].originalTitle,
            posterPathMovie: popularMovies[0].posterPath,
            movieId: popularMovies[0].id,
            voteAverage: popularMovies[0].voteAverage),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Popular Movies',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 180,
          child: ListView.builder(
            itemCount: popularMovies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final MovieModel movie = popularMovies[index];

              return CardMedia(
                mediaTitle: movie.originalTitle,
                posterPath: movie.posterPath,
                mediaType: EnumMediaType.movie,
                mediaId: movie.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
