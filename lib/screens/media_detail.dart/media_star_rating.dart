import 'package:flutter/material.dart';

class CustomStarRating extends StatelessWidget {
  const CustomStarRating({
    super.key,
    required this.voteAverage,
  });

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          color: Color.fromARGB(255, 248, 212, 95),
          size: 18,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          voteAverage.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
