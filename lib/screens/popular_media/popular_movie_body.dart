import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/popular_media/most_popular_movie_card.dart';
import 'package:flutter_fiveflix/screens/widgets/card_media.dart';

class PopularMoviebody extends StatelessWidget {
  const PopularMoviebody({
    super.key,
    required this.popularMovies,
  });

  final List<PopularMovieModel> popularMovies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MostPopularMovieCard(
          nameMovie: popularMovies[0].originalTitle,
          genresMovie: popularMovies[0].genres,
          posterPathMovie: popularMovies[0].posterPath,
        ),
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
              final movie = popularMovies[index];

              return CardMedia(
                mediaTitle: movie.originalTitle,
                posterPath: movie.posterPath,
                mediaType: movie.mediaType,
                mediaId: movie.id,
              );
            },
          ),
        ),
      ],
    );
  }
}
