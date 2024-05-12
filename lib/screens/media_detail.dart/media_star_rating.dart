import 'package:flutter/material.dart';

class CustomStarRating extends StatelessWidget {
  const CustomStarRating({
    super.key,
    required this.voteAverage,
  });

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const SizedBox(height: 10),
          const Icon(
            Icons.star,
            color: Color.fromARGB(255, 248, 212, 95),
            size: 20,
          ),
          const SizedBox(
            width: 3.0,
          ),
          //      const  SizedBox(height: 50.0,),
          Text(
            voteAverage.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 15.5,
              color: Color.fromARGB(175, 143, 152, 173),
            ),
          ),
        ],
      ),
    );
  }
}
