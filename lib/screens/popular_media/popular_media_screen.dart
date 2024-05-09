import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_event.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_state.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
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
  List<PopularMovieModel> popularMovies = [];
  List<PopularSerieModel> popularSeries = [];

  @override
  void initState() {
    super.initState();

    context.read<PopularMediaBloc>().add(PopularMediaFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<PopularMediaBloc, PopularMediaState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorMessage();
          } else if (state is SuccessState) {
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

          return const ErrorMessage();
        },
      ),
    );
  }
}
