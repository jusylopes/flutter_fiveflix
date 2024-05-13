import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/game/game_screen.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';


class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Games',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: GameQuestions.games().length,
            itemBuilder: (BuildContext context, int index) {
              final GameModel game = GameQuestions.games()[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          game: game,
                        ),
                      ),
                    );
                  },
                  leading: Stack(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 150,
                        child: Image.asset(
                          game.posterPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    game.nameGame,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
