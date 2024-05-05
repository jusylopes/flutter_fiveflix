import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class CardMedia extends StatelessWidget {
  const CardMedia({
    super.key,
    required this.mediaTitle,
    required this.posterPath,
  });

  final String mediaTitle;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 100,
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Image.network(AppStrings.urlImagePoster + posterPath),
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
