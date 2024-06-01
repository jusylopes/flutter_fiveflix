import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media/media_bloc.dart';
import 'package:flutter_fiveflix/models/media_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_item_tile.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';

class MovieRecomended extends StatefulWidget {
  const MovieRecomended({super.key});

  @override
  State<MovieRecomended> createState() => _MovieRecomendedState();
}

class _MovieRecomendedState extends State<MovieRecomended> {
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
          final List<MediaModel> topRatedMovies = state.topRatedMovies;

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
                      final MediaModel topMovie = topRatedMovies[index];

                      return MediaItemTile(
                        media: topMovie,
                        mediaType: MediaType.movie,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
