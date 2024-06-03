part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameFetchEvent extends GameEvent {
  @override
  List<Object> get props => [];
}
