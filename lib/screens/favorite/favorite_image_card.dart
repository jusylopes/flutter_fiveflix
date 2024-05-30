import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteImageCard extends StatelessWidget {
  const FavoriteImageCard({
    super.key,
    required this.item,
  });

  final FavoriteModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: SizedBox(
        height: 95,
        width: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImageMedia(
            boxFit: BoxFit.cover,
            url: FiveflixStrings.urlImagePoster + item.posterPath,
          ),
        ),
      ),
    );
  }
}
