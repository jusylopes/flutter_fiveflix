import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CardMedia extends StatelessWidget {
  const CardMedia({
    super.key,
    required this.mediaTitle,
    required this.posterPath,
    required this.mediaType,
    required this.mediaId,
  });

  final String mediaTitle;
  final String posterPath;
  final int mediaId;
  final EnumMediaType mediaType;

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
                mediaId: mediaId,
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
                    child: CachedNetworkImage(
                      imageUrl: AppStrings.urlImagePoster + posterPath,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      placeholder: (context, url) =>
                          const CircularProgressIndicatorApp(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
              mediaTitle,
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
