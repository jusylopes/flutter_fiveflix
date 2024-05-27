import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class ResultGameScreen extends StatelessWidget {
  final int score;
  final int numberQuestions;

  const ResultGameScreen(
      {super.key, required this.score, required this.numberQuestions});

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
            const SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: FiveflixColors.backgroundColor,
              backgroundImage: AssetImage(
                isWinner
                    ? FiveflixAssetsManager.winnerGame
                    : FiveflixAssetsManager.loserGame,
              ),
              radius: 120.0,
            ),
          ],
        ),
      ),
    );
  }
}
