import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/game/game_screen.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';

class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Games',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: GameQuestions.games().length,
        itemBuilder: (BuildContext context, int index) {
          final GameModelVersion1 game = GameQuestions.games()[index];

          return GestureDetector(
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: SizedBox(
                    height: 110,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        game.posterPath,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      game.nameGame,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
