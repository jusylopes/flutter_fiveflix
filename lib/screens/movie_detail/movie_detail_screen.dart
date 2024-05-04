import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_event.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_state.dart';
import 'package:flutter_fiveflix/screens/movie_detail/movie_detail_body.dart';
import 'package:flutter_fiveflix/screens/movie_detail/movie_detail_header_image.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';


class MovieDetailScreen extends StatefulWidget {
  final int _movieId;

  const MovieDetailScreen({super.key, required int movieId})
      : _movieId = movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = BlocProvider.of<MovieDetailBloc>(context);
    _movieDetailBloc.add(MovieDetailFetchEvent(widget._movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorMessage();
          } else if (state is SuccessState) {
            return Column(
              children: [
                MovieDetailHeaderImage(movie: state.movie),
                MovieDetailBody(movie: state.movie)
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
