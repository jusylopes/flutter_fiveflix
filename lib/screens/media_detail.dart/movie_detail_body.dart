import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/cast_model.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/cast_widget.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/media_detail_row.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/story_line_widget.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({
    super.key,
    required this.movie,
    required this.castList,
  });

  final MovieDetailModel movie;
  final List<CastModel> castList;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            MediaChipGenre(
              genresMovie: movie.genres,
              wrapAlignment: WrapAlignment.start,
            ),
            MediaDetailRow(
              voteAverage: movie.voteAverage,
              runtime: movie.runtime,
              releaseDate: movie.releaseDate,
            ),
            StoryLineWidget(mediaOverview: movie.overview),
            CastWidget(castList: castList),
          ],
        ));
  }
}
