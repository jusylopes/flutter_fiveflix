import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/movie_detail_body.dart';
import 'package:flutter_fiveflix/screens/media_detail/serie_detail_body.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MediaDetailScreen extends StatefulWidget {
  final int mediaId;
  final EnumMediaType mediaType;

  const MediaDetailScreen(
      {super.key, required this.mediaId, required this.mediaType});

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen> {
  @override
  void initState() {
    super.initState();

    widget.mediaType == EnumMediaType.movie
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
          if (state is MediaDetailInitialState ||
              state is MediaDetailLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaDetailErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is MovieDetailSuccessState) {
            MovieDetailModel movie = state.movie;
            List<CastModel> castMovie = state.castMovie;
            List<TrailerModel> trailerMovie = state.trailer;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaDetailHeaderImage(posterPathMedia: movie.posterPath),
                  MovieDetailBody(
                    movie: movie,
                    castList: castMovie,
                    trailerList: trailerMovie,
                  ),
                ],
              ),
            );
          } else if (state is SerieDetailSuccessState) {
            SerieDetailModel serie = state.serie;
            List<CastModel> castSerie = state.castSerie;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaDetailHeaderImage(posterPathMedia: serie.posterPath),
                  SerieDetailBody(
                    serie: serie,
                    castList: castSerie,
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
