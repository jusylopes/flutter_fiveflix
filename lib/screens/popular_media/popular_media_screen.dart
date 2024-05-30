import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_movie_cards.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_serie_cards.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class PopularMediaScreen extends StatefulWidget {
  const PopularMediaScreen({super.key});

  @override
  State<PopularMediaScreen> createState() => _PopularMediaScreenState();
}

class _PopularMediaScreenState extends State<PopularMediaScreen> {
  List<MediaModel> popularMovies = [];
  List<MediaModel> popularSeries = [];

  @override
  void initState() {
    super.initState();
    context.read<MediaBloc>().add(PopularMediaFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaInitialState || state is MediaLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is PopularSuccessState) {
            popularMovies = state.popularMovies;
            popularSeries = state.popularSeries;
          }

          if (popularMovies.isNotEmpty && popularSeries.isNotEmpty) {
            return Column(
              children: [
                Column(
                  children: [
                    MostPopularMediaCard(
                      media: popularMovies[0],
                      mediaType: MediaType.movie,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PopularMediaCards(
                      popularMovies: popularMovies,
                    ),
                  ],
                ),
                PopularSerieCards(popularSeries: popularSeries),
              ],
            );
          }

          return const FiveflixCircularProgressIndicator();
        },
      ),
    );
  }
}
