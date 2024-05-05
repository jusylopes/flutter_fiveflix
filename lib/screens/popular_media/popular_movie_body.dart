import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_state.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/movie_detail/most_popular_movie_card.dart';
import 'package:flutter_fiveflix/screens/widgets/card_media.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class PopularMoviebody extends StatelessWidget {
  const PopularMoviebody({
    super.key,
    required this.popularMovies,
    required this.screenHeight,
  });

  final List<PopularMovieModel> popularMovies;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        if (state is InitialState ||
            (state is LoadingState && popularMovies.isEmpty)) {
          return const CircularProgressIndicatorApp();
        } else if (state is ErrorState) {
          return const ErrorMessage();
        } else if (state is SuccessState) {
          popularMovies.addAll(state.popularMovies);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MostPopularMovieCard(
              nameMovie: popularMovies[0].originalTitle,
              genresMovie: popularMovies[0].genres,
              posterPathMovie: popularMovies[0].posterPath,
              screenHeight: screenHeight,
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
