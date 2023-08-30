part of 'favorite_starship_bloc.dart';

abstract class FavoriteStarshipState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyState extends FavoriteStarshipState {}

class LoadingState extends FavoriteStarshipState {}

class LoadedState extends FavoriteStarshipState {
  final List<Starship> listOfFavoriteStarship;

  LoadedState({required this.listOfFavoriteStarship});

  @override
  List<Object> get props => [listOfFavoriteStarship];
}

class ErrorState extends FavoriteStarshipState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
