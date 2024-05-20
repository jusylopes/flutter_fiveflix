import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/media_bloc.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/media_movie_model.dart';

import 'package:flutter_fiveflix/screens/widgets/custom_list_tile_app.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';

class RecomendedMovies extends StatefulWidget {
  const RecomendedMovies({super.key});

  @override
  State<RecomendedMovies> createState() => _RecomendedMoviesState();
}

class _RecomendedMoviesState extends State<RecomendedMovies> {
  @override
  void initState() {
    super.initState();
    context.read<MediaBloc>().add(TopRatedFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
      builder: (context, state) {
        if (state is TopRatedSucessState) {
          final List<MediaMovieModel> topRatedMovies = state.topRatedMovies;

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
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: topRatedMovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MediaMovieModel topMovie = topRatedMovies[index];

                      return CustomListTile(
                        titleMedia: topMovie.title,
                        idMedia: topMovie.id,
                        posterPathMedia: topMovie.backdropPath,
                        mediaType: EnumMediaType.movie,
                        voteAverage: topMovie.voteAverage,
                      );
                    },
                  ),
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
