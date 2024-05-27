import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/fiveflix_strings.dart';

class StoryLineWidget extends StatelessWidget {
  final String mediaOverview;

  const StoryLineWidget({
    super.key,
    required this.mediaOverview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          'Story Line',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            mediaOverview.isEmpty
                ? FiveflixStrings.storyLineIsEmpty
                : mediaOverview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
