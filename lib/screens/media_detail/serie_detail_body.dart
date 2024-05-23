import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/cast_model.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/cast_widget.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_row.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/story_line_widget.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';

class SerieDetailBody extends StatelessWidget {
  const SerieDetailBody({
    super.key,
    required this.serie,
    required this.castList,
  });

  final SerieDetailModel serie;
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
            serie.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          MediaChipGenre(
            genresMovie: serie.genres,
            wrapAlignment: WrapAlignment.start,
          ),
          MediaDetailRow(
            voteAverage: serie.voteAverage,
            numberOfSeasons: serie.numberOfSeasons,
            releaseDate: serie.firstAirDate,
          ),
          StoryLineWidget(mediaOverview: serie.overview),
          CastWidget(castList: castList),
        ],
      ),
    );
  }
}
