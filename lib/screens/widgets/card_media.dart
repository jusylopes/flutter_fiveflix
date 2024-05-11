import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/media_type.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
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
  final MediaType mediaType;

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
                Image.network(AppStrings.urlImagePoster + posterPath),
                const CustomSymbolApp(
                  symbolHeight: 30,
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
