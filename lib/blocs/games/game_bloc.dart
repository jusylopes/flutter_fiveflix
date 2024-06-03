import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/repositories/game_repository.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository;

  GameBloc({required GameRepository repository})
      : _repository = repository,
        super(GameInitialState()) {
    on<GameFetchEvent>(_onGameFetchEvent);
  }

  void _onGameFetchEvent(GameFetchEvent event, Emitter<GameState> emit) async {
    emit(GameLoadingState());

    try {
      final List<GameModel> games = await _repository.getListGame(
        endpoint: FiveflixStrings.baseUrlApiGames,
        fromJson: (json) => GameModel.fromJson(json),
      );
      emit(
        GameSuccessState(games: games),
      );
    } catch (e) {
      emit(
        GameErrorState(e.toString()),
      );
    }
  }
}
