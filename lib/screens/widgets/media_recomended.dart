import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/media_bloc.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/movie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_list_item.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';

class MediaRecomended extends StatefulWidget {
  const MediaRecomended({super.key});

  @override
  State<MediaRecomended> createState() => _MediaRecomendedState();
}

class _MediaRecomendedState extends State<MediaRecomended> {
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
          final List<MovieModel> topRatedMovies = state.topRatedMovies;

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
                      final MovieModel topMovie = topRatedMovies[index];

                      return MediaListItem(
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
