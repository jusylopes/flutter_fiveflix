import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/media_bloc.dart';
import 'package:flutter_fiveflix/models/media_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_movie_body.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_serie_body.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class PopularMediaScreen extends StatefulWidget {
  const PopularMediaScreen({super.key});

  @override
  State<PopularMediaScreen> createState() => _PopularMediaScreenState();
}

class _PopularMediaScreenState extends State<PopularMediaScreen> {
  List<MediaMovieModel> popularMovies = [];
  List<PopularSerieModel> popularSeries = [];

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
          if (state is InitialState || state is LoadingState) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorLoadingMessage();
          } else if (state is PopularSuccessState) {
            popularMovies.addAll(state.popularMovies);
            popularSeries.addAll(state.popularSeries);
          }

          if (popularMovies.isNotEmpty && popularSeries.isNotEmpty) {
            return Column(
              children: [
                PopularMoviebody(
                  popularMovies: popularMovies,
                ),
                PopularSeriebody(popularSeries: popularSeries),
              ],
            );
          }

          return const CircularProgressIndicatorApp();
        },
      ),
    );
  }
}
