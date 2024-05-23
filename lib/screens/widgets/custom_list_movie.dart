import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/media_star_rating.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CustomListMovie extends StatelessWidget {
  const CustomListMovie({
    super.key,
    required this.movies,
  });

  final List<PopularMovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final PopularMovieModel movie = movies[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaDetailScreen(
                        mediaId: movie.id, mediaType: EnumMediaType.movie),
                  ),
                );
              },
              leading: Stack(
                children: [
                  SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        AppStrings.urlImagePoster + movie.posterPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const CustomSymbolApp(symbolHeight: 20.0)
                ],
              ),
              title: Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: CustomStarRating(voteAverage: movie.voteAverage),
            );
          }),
    );
  }
}

