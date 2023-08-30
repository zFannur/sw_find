part of 'starship_bloc.dart';

abstract class StarshipState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends StarshipState {}

class Loading extends StarshipState {}

class Loaded extends StarshipState {
  final List<Starship> listOfStarship;

  Loaded({required this.listOfStarship});

  @override
  List<Object> get props => [listOfStarship];
}

class Error extends StarshipState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
