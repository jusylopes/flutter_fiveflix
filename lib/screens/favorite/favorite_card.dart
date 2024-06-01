import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.itemFavorite,
  });

  final MediaModel itemFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaDetailScreen(
              media: itemFavorite,
              mediaType:
                  itemFavorite.isMovie ? MediaType.movie : MediaType.serie,
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
                      url: FiveflixStrings.urlImagePoster +
                          itemFavorite.posterPath,
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
                itemFavorite.isMovie ? itemFavorite.title! : itemFavorite.name!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Row(
                children: [
                  CustomStarRating(
                    voteAverage: itemFavorite.voteAverage,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    itemFavorite.isMovie
                        ? (itemFavorite.releaseDate?.year.toString() ?? '')
                        : (itemFavorite.firstAirDate?.year.toString() ?? ''),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              trailing: CircleAvatar(
                backgroundColor: FiveflixColors.primaryColor,
                child: IconButton(
                  onPressed: () {
                    _showConfirmationRemoveFavoriteDialog(
                        context, itemFavorite);
                  },
                  icon: const Icon(Icons.remove),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_showConfirmationRemoveFavoriteDialog(BuildContext context, MediaModel item) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            'Are you sure you want to delete this favorite?',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  context
                      .read<FavoriteBloc>()
                      .add(FavoriteRemoveItemEvent(id: item.id));
                },
                child: Text('DELETE',
                    style: Theme.of(context).textTheme.titleMedium)),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'CANCEL',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
          backgroundColor: FiveflixColors.primaryColor,
        );
      });
}
