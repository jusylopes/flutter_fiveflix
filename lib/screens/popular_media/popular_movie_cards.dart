import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/card_media.dart';

class PopularMediaCards extends StatelessWidget {
  final List<MediaModel> popularMovies;

  const PopularMediaCards({
    super.key,
    required this.popularMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Popular Movies',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 180,
          child: ListView.builder(
            itemCount: popularMovies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final MediaModel movie = popularMovies[index];

              return CardMedia(
                media: movie,
                mediaType: MediaType.movie,
              );
            },
          ),
        ),
      ],
    );
  }
}
