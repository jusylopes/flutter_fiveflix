import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/search_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CustomListMedia extends StatelessWidget {
  const CustomListMedia({
    super.key,
    required this.movies,
  });

  final List<SearchModel> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaDetailScreen(
                      mediaId: movie.id,
                      mediaType: EnumMediaType.movie,
                    ),
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                movie.popularity.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            );
          }),
    );
  }
}