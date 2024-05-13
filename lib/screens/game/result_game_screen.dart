import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/strings.dart';
import 'package:lottie/lottie.dart';

class ResultGameScreen extends StatelessWidget {
  const ResultGameScreen(
      {super.key, required this.score, required this.numberQuestions});

  final int score;
  final int numberQuestions;

  @override
  Widget build(BuildContext context) {
    bool isWinner = (score / numberQuestions) > 0.5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You get $score / $numberQuestions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Lottie.network(
              isWinner ? AppStrings.gameWinner : AppStrings.gameError,
            ),
          ],
        ),
      ),
    );
  }
}
