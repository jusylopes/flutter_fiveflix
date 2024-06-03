import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class CardMovieSpecialGame extends StatelessWidget {
  const CardMovieSpecialGame({
    super.key,
    required this.heightScreen,
    required this.media,
    required this.movieGenres,
  });

  final double heightScreen;
  final MediaModel media;
  final List<GenreModel> movieGenres;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: heightScreen / 2.5,
                    child: Image.network(
                      FiveflixStrings.urlImagePoster + media.posterPath,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomSymbolApp(symbolHeight: 30.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                media.isMovie ? media.title! : media.name!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                children: movieGenres.map((genre) {
                  return Text(
                    genre.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaDetailScreen(
                      media: media,
                      mediaType: MediaType.movie,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    label: Row(
                      children: [
                        Text('View more',
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    backgroundColor: FiveflixColors.primaryColor,
                    side: const BorderSide(
                      width: 0,
                      color: FiveflixColors.primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
