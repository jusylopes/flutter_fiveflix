import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/cached_network_image.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/fiveflix_strings.dart';

class CardMedia extends StatelessWidget {
  final MediaModel media;
  final MediaType mediaType;

  const CardMedia({
    super.key,
    required this.media,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 100,
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaDetailScreen(
                media: media,
                mediaType: mediaType,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 130,
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
              mediaType == MediaType.movie ? media.title! : media.name!,
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
