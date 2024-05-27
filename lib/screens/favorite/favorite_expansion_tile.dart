import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

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
      title: Row(
        children: [
          SizedBox(
            width: screenWidth / 3.2,
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CircleAvatar(
              backgroundColor: FiveflixColors.primaryColor,
              child: IconButton(
                onPressed: () {
                  _showConfirmationRemoveFavoriteDialog(context);
                },
                icon: const Icon(Icons.remove),
                color: Colors.white,
              ),
            ),
          ),
        ],
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
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Story Line',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            item.overview.isEmpty
                ? FiveflixStrings.storyLineIsEmpty
                : item.overview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  _showConfirmationRemoveFavoriteDialog(BuildContext context) {
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
                        .add(FavoriteRemoveEvent(id: item.id));
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
}
