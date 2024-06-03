part of 'game_bloc.dart';

abstract class GameState extends Equatable {}

class GameInitialState extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoadingState extends GameState {
  @override
  List<Object> get props => [];
}

class GameSuccessState extends GameState {
  GameSuccessState({required this.games});

  final List<GameModel> games;

  @override
  List<Object> get props => [];
}

class GameErrorState extends GameState {
  final String errorMessage;

  GameErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
