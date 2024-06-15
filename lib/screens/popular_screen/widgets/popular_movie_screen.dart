import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_media_cards.dart';
import 'package:flutter_fiveflix/screens/widgets/error_loading_message.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';
import 'package:flutter_fiveflix/screens/widgets/most_popular_media_card.dart';

class PopularMovieScreen extends StatefulWidget {
  const PopularMovieScreen({super.key});

  @override
  State<PopularMovieScreen> createState() => _PopularMovieScreenState();
}

class _PopularMovieScreenState extends State<PopularMovieScreen> {
  late List<MediaModel> medias;
  late List<MediaModel> mediasUpcoming;

  @override
  void initState() {
    super.initState();
    medias = [];
    mediasUpcoming = [];

    context.read<MediaBloc>().add(PopularMovieFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<MediaBloc, MediaState>(
          builder: (context, state) {
            if (state is MediaInitialState || state is MediaLoadingState) {
              return const FiveflixCircularProgressIndicator();
            } else if (state is MediaErrorState) {
              return ErrorLoadingMessage(
                errorMessage: state.errorMessage,
              );
            } else if (state is PopularMovieSuccessState) {
              medias = state.popularMedias;
              mediasUpcoming = state.upCommingMedias;
            }

            if (medias.isNotEmpty && mediasUpcoming.isNotEmpty) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MostPopularMediaCard(
                        media: medias[0],
                        mediaType: MediaType.movie,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PopularMediaCards(
                        key: Key(
                          WidgetKeys.moviesCard.key,
                        ),
                        medias: medias,
                        titleMedia: 'Movies',
                      ),
                      PopularMediaCards(
                        medias: mediasUpcoming,
                        titleMedia: 'Upcoming Movies',
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
