import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/screens/widgets/media_star_rating.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.titleMedia,
    required this.idMedia,
    required this.posterPathMedia,
    required this.mediaType,
    required this.voteAverage,
  });

  final String titleMedia;
  final int idMedia;
  final double voteAverage;
  final String posterPathMedia;
  final EnumMediaType mediaType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaDetailScreen(
                mediaId: idMedia, mediaType: EnumMediaType.movie),
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
                AppStrings.urlImagePoster + posterPathMedia,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const CustomSymbolApp(symbolHeight: 20.0)
        ],
      ),
      title: Text(
        titleMedia,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: CustomStarRating(voteAverage: voteAverage),
    );
  }
}
