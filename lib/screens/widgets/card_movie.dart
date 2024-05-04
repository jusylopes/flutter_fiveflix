import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: SizedBox(
        height: 130,
        width: 100,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Container(
                height: 130,
                decoration: const BoxDecoration(),
                child: Image.network(AppStrings.urlImagePoster + posterPath),
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
      ),
    );
  }
}
