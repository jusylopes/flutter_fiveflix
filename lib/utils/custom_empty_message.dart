import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/media_recomended.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class CustomEmptyMessage extends StatelessWidget {
  const CustomEmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              FiveflixStrings.emptyMediaMessage,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        const Expanded(child: MediaRecomended()),
      ],
    );
  }
}
