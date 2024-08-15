import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/cached_network_image.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/fiveflix_strings.dart';

class CardMedia extends StatelessWidget {
  final MediaModel media;

  const CardMedia({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 6),
      width: 110,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaDetailScreen(
                media: media,
                mediaType: media.isMovie ? MediaType.movie : MediaType.serie,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImageMedia(
                      url: FiveflixStrings.urlImagePoster + media.posterPath,
                    ),
                  ),
                ),
                const CustomSymbolApp(
                  symbolHeight: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              media.isMovie
                  ? media.title ?? 'Title not available'
                  : media.name ?? 'Name not available',
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
