part of 'favorite_starship_bloc.dart';

abstract class FavoriteStarshipEvent extends Equatable {
  const FavoriteStarshipEvent();
}

class AddFavoriteStarshipBlocEvent extends FavoriteStarshipEvent {
  final Starship starship;

  const AddFavoriteStarshipBlocEvent({required this.starship});

  @override
  List<Object> get props => [starship];
}

class GetAllFavoriteStarshipBlocEvent extends FavoriteStarshipEvent {
  const GetAllFavoriteStarshipBlocEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteStarshipIdBlocEvent extends FavoriteStarshipEvent {
  final int id;

  const DeleteFavoriteStarshipIdBlocEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchFavoriteStarshipIdBlocEvent extends FavoriteStarshipEvent {
  final String? keyword;

  const SearchFavoriteStarshipIdBlocEvent({required this.keyword});

  @override
  List<Object> get props => [];
}