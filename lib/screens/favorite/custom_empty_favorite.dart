import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class CustomEmptyFavorite extends StatelessWidget {
  const CustomEmptyFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            FiveflixAssetsManager.imageSymbol,
            height: 50.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            FiveflixStrings.emptyMessageFavorite,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
