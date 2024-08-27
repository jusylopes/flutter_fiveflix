import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class GridViewAllMedia extends StatelessWidget {
  const GridViewAllMedia({
    super.key,
    required this.allMedia,
    required ScrollController scrollController,
    required this.screenWidth,
  }) : _scrollController = scrollController;

  final List<MediaModel> allMedia;
  final ScrollController _scrollController;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: allMedia.length,
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            mainAxisSpacing: 16,
            crossAxisCount: screenWidth ~/ 120,
            childAspectRatio: 10 / 19),
        itemBuilder: (context, index) {
          final MediaModel media = allMedia[index];

          return GestureDetector(
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
            child: GridTile(
              header: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImageMedia(
                  boxFit: BoxFit.cover,
                  url: media.posterPath != null
                      ? FiveflixStrings.urlImagePoster + media.posterPath!
                      : '',
                ),
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
