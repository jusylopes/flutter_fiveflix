import 'package:equatable/equatable.dart';

abstract class PopularMediaEvent extends Equatable {
  const PopularMediaEvent();
}

class PopularMediaFetchEvent extends PopularMediaEvent {
  @override
  List<Object> get props => [];
}


