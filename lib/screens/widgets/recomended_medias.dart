import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_bloc.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_list_movie.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';

class RecomendedMovies extends StatelessWidget {
  const RecomendedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMediaBloc, PopularMediaState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final List<PopularMovieModel> popularMovies = state.popularMovies;
          final List<PopularMovieModel> suggestionsMovies =
              popularMovies.take(5).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Text(
                  'Movies Top Rated',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: CustomListMovie(
                  movies: suggestionsMovies,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicatorApp();
        }
      },
    );
  }
}
