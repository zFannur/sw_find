part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyState extends FavoriteState {}

class LoadingState extends FavoriteState {}

class LoadedState extends FavoriteState {
  final List<Person> listOfFavoritePeople;

  LoadedState({required this.listOfFavoritePeople});

  @override
  List<Object> get props => [listOfFavoritePeople];
}

class ErrorState extends FavoriteState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
