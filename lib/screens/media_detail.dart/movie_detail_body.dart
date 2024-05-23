import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/cast_model.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/cast_widget.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/favorite_button.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/media_detail_row.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/story_line_widget.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/widgets/title_media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';
import 'package:flutter_fiveflix/utils/colors.dart';

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
                  width: widthScreen / 1.6,
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
                StoryLineWidget(mediaOverview: movie.overview),
                CastWidget(castList: castList),
              ],
            ),
            const FavoriteButton(),
          ],
        ));
  }
}
