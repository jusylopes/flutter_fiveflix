import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

import 'widgets_exports.dart';

class MediaItemTile extends StatelessWidget {
  final MediaModel media;
  final MediaType mediaType;

  const MediaItemTile({
    super.key,
    required this.media,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImageMedia(
                      boxFit: BoxFit.cover,
                      url: FiveflixStrings.urlImagePoster + media.posterPath,
                    ),
                  ),
                ),
                const CustomSymbolApp(symbolHeight: 22.0)
              ],
            ),
          ),
          Expanded(
            child: ListTile(
                title: Text(
                  mediaType == MediaType.movie ? media.title! : media.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: MediaDetailRow(
                  voteAverage: media.voteAverage,
                  releaseDate: mediaType == MediaType.movie
                      ? media.releaseDate!
                      : media.firstAirDate!,
                )),
          ),
        ],
      ),
    );
  }
}
