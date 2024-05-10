import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';

class MediaDetailBody extends StatelessWidget {
  const MediaDetailBody({
    super.key,
    required this.movie,
  });

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          MediaChipGenre(
              genresMovie: movie.genres, wrapAlignment: WrapAlignment.start)
        ],
      ),
    );
  }
}
