import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({
    super.key,
    required this.movie,
    required this.castList,
    required this.trailerList,
  });

  final MovieDetailModel movie;
  final List<CastModel> castList;
  final List<TrailerModel> trailerList;

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
                  titleMedia: movie.title,
                ),
                SizedBox(
                  width: widthScreen / 1.3,
                  child: MediaChipGenre(
                    genresMovie: movie.genres,
                    wrapAlignment: WrapAlignment.start,
                  ),
                ),
                MediaDetailRow(
                  voteAverage: movie.voteAverage,
                  runtime: movie.runtime,
                  releaseDate: movie.releaseDate,
                ),
                if (trailerList.isNotEmpty)
                  TrailerWidget(
                    trailerList: trailerList,
                  ),
                StoryLineWidget(mediaOverview: movie.overview),
                CastWidget(castList: castList),
              ],
            ),
            const FavoriteButton(),
          ],
        ));
  }
}
