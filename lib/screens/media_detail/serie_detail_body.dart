import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
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
    final double widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleMediaDetailScreen(
                widthScreen: widthScreen,
                titleMedia: serie.name,
              ),
              SizedBox(
                width: widthScreen / 1.3,
                child: MediaChipGenre(
                  genresMovie: serie.genres,
                  wrapAlignment: WrapAlignment.start,
                ),
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
          const FavoriteButton(),
        ],
      ),
    );
  }
}
