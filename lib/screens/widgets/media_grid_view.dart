import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MediaGridView extends StatelessWidget {
  final List<MediaModel> mediaList;
  final MediaType mediaType;

  const MediaGridView(
      {super.key, required this.mediaList, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
        itemCount: mediaList.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            mainAxisSpacing: 16,
            crossAxisCount: screenWidth ~/ 80,
            childAspectRatio: 9 / 19),
        itemBuilder: (context, index) {
          final MediaModel media = mediaList[index];

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
            child: GridTile(
              header: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImageMedia(
                      boxFit: BoxFit.cover,
                      url: FiveflixStrings.urlImagePoster + media.posterPath,
                    ),
                  ),
                  const CustomSymbolApp(symbolHeight: 22.0)
                ],
              ),
              footer: Text(
                  media.isMovie
                      ? media.title ?? 'Title not available'
                      : media.name ?? 'Name not available',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall),
              child: const SizedBox.shrink(),
            ),
          );
        });
  }
}
