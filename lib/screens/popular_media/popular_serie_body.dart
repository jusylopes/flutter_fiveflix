import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/card_media.dart';

class PopularSeriebody extends StatelessWidget {
  const PopularSeriebody({
    super.key,
    required this.popularSeries,
  });

  final List<PopularSerieModel> popularSeries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Popular Series',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 200,
          child: ListView.builder(
            itemCount: popularSeries.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final serie = popularSeries[index];

              return CardMedia(
                mediaTitle: serie.originalName,
                posterPath: serie.posterPath,
                mediaId: serie.id,
                mediaType: serie.mediaType,
              );
            },
          ),
        ),
      ],
    );
  }
}
