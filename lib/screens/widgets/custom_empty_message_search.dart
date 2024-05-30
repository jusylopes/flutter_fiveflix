import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/movie_recomended.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class CustomEmptyMessageSearch extends StatelessWidget {
  const CustomEmptyMessageSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              FiveflixStrings.emptyMediaMessageSearch,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        const Expanded(child: MovieRecomended()),
      ],
    );
  }
}
