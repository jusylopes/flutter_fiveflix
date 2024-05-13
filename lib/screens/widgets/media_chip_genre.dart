import 'package:flutter/material.dart';

class MediaChipGenre extends StatelessWidget {
  const MediaChipGenre({
    super.key,
    required this.genresMovie,
    required this.wrapAlignment,
  });

  final List genresMovie;
  final WrapAlignment wrapAlignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: wrapAlignment,
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
