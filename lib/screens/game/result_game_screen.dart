import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/assets_manager.dart';
import 'package:flutter_fiveflix/utils/colors.dart';

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
            const SizedBox(height: 20.0),
            CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              backgroundImage: AssetImage(
                isWinner ? AssetsManager.winnerGame : AssetsManager.loserGame,
              ),
              radius: 120.0,
            ),
          ],
        ),
      ),
    );
  }
}
