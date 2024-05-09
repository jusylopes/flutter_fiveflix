import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';

class MediaChipGenre extends StatelessWidget {
  const MediaChipGenre({
    super.key,
    required this.genresMovie,
  });

  final List<Genre> genresMovie;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      children: genresMovie.map((genre) {
        return Text(
          genre.name,
          style: Theme.of(context).textTheme.titleSmall,
        );
      }).toList(),
    );
  }
}
