import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/media_star_rating.dart';

class MediaDetailRow extends StatelessWidget {
  final DateTime releaseDate;
  final double voteAverage;

  const MediaDetailRow({
    super.key,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            CustomStarRating(
              voteAverage: voteAverage,
            ),
            const SizedBox(width: 15),
            Text(
              '${releaseDate.year}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
