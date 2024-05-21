import 'package:flutter/material.dart';

class StoryLineWidget extends StatelessWidget {
  const StoryLineWidget({
    super.key,
    required this.mediaOverview,
  });

  final String mediaOverview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Story Line',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            mediaOverview,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
