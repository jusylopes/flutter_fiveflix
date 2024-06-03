import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  final List favoriteList;
  final int mediaId;
  const FavoriteIcon(
      {super.key, required this.favoriteList, required this.mediaId});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoriteList.any(
      (item) => item.id == mediaId,
    );

    return isFavorite
        ? const Icon(
            Icons.check,
            color: Colors.white,
          )
        : const Icon(
            Icons.add,
            color: Colors.white,
          );
  }
}
