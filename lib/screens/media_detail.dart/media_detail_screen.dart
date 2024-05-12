import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_bloc.dart';
import 'package:flutter_fiveflix/models/media_type.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_body.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_header_image.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/serie_detail_body.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class MediaDetailScreen extends StatefulWidget {
  const MediaDetailScreen(
      {super.key, required this.mediaId, required this.mediaType});
  final int mediaId;
  final MediaType mediaType;

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen> {
  @override
  void initState() {
    super.initState();

    widget.mediaType == MediaType.movie
        ? context
            .read<MediaDetailBloc>()
            .add(MovieDetailFetchEvent(id: widget.mediaId))
        : context
            .read<MediaDetailBloc>()
            .add(SerieDetailFetchEvent(id: widget.mediaId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MediaDetailBloc, MediaDetailState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorMessage();
          } else if (state is MovieDetailSuccessState) {
            MovieDetailModel movie = state.movie;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaDetailHeaderImage(posterPathMedia: movie.posterPath),
                  MediaDetailBody(
                    movie: movie,
                  ),
                ],
              ),
            );
          } else if (state is SerieDetailSuccessState) {
            SerieDetailModel serie = state.serie;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaDetailHeaderImage(posterPathMedia: serie.posterPath),
                  SerieDetailBody(
                    serie: serie,
                  ),
                ],
              ),
            );
          }

          return const Center();
        },
      ),
    );
  }
}
