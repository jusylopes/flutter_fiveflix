import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/serie_detail_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_star_rating.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';

class SerieDetailBody extends StatelessWidget {
  const SerieDetailBody({
    super.key,
    required this.serie,
  });

  final SerieDetailModel serie;

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
          const SizedBox(
            height: 8,
          ),
          MediaChipGenre(
            genresMovie: serie.genres,
            wrapAlignment: WrapAlignment.start,
          ),
          const SizedBox(height: 8),
          CustomStarRating(
            voteAverage: serie.voteAverage,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Story Line',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            serie.overview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
