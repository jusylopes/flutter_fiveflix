import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/media_star_rating.dart';

class MediaDetailRow extends StatelessWidget {
  final DateTime releaseDate;
  final int runtime;
  final double voteAverage;
  final int numberOfSeasons;

  const MediaDetailRow({
    super.key,
    required this.releaseDate,
    required this.voteAverage,
    this.runtime = 0,
    this.numberOfSeasons = 0,
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
            if (runtime > 0) ...[
              const SizedBox(width: 15),
              Text(
                _formatRuntime(runtime),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
            if (numberOfSeasons > 0) ...[
              const SizedBox(width: 15),
              Text(
                '$numberOfSeasons ${numberOfSeasons == 1 ? 'Season' : 'Seasons'}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  String _formatRuntime(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours}h ${minutes}m';
  }
}
