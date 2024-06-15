import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/widgets_keys.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';
import 'package:flutter_fiveflix/screens/game/game_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/cached_network_image.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  late List<GameModel> games;

  @override
  void initState() {
    games = [];

    context.read<GameBloc>().add(GameFetchEvent());
    super.initState();
  }

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
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is GameErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is GameSuccessState) {
            games = state.games;
          }
          if (games.isNotEmpty) {
            return ListView.builder(
              key: Key(WidgetKeys.gamesCard.key),
              itemCount: games.length,
              itemBuilder: (BuildContext context, int index) {
                final GameModel game = games[index];

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
                            child:
                                CachedNetworkImageMedia(url: game.posterPath),
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
            );
          }
          return const FiveflixCircularProgressIndicator();
        },
      ),
    );
  }
}
