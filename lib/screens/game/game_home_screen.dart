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
          final GameModel game = GameQuestions.games()[index];

          return ListTile(
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
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      game.posterPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              game.nameGame,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        },
      ),
    );
    
  }
}
