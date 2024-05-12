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
          const SizedBox(height: 10),
          MediaChipGenre(
            genresMovie: movie.genres,
            wrapAlignment: WrapAlignment.start,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 248, 212, 95),
                size: 20,
              ),
              const SizedBox(
                width: 5.0,
              ),
              //      const  SizedBox(height: 50.0,),

              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: const TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 15.5,
                  color: Color.fromARGB(175, 143, 152, 173),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Story Line',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            movie.overview,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
