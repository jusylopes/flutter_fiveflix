import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteExpansionTile extends StatelessWidget {
  const FavoriteExpansionTile({
    super.key,
    required this.item,
  });

  final FavoriteModel item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(8.0),
      expandedAlignment: Alignment.topLeft,
      leading: Stack(
        children: [
          SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImageMedia(
                boxFit: BoxFit.cover,
                url: FiveflixStrings.urlImagePoster + item.posterPath,
              ),
            ),
          ),
          const CustomSymbolApp(symbolHeight: 20.0)
        ],
      ),
      title: Text(
        item.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: CustomStarRating(
        voteAverage: item.voteAverage,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      collapsedBackgroundColor: FiveflixColors.backgroundColor,
      backgroundColor: FiveflixColors.backgroundColor,
      children: [
        Text(
          'Story Line',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            item.overview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
