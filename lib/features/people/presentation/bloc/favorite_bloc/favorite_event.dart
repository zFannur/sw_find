part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class AddFavoritePeopleBlocEvent extends FavoriteEvent {
  final Person person;

  const AddFavoritePeopleBlocEvent({required this.person});

  @override
  List<Object> get props => [person];
}

class GetAllFavoritePeopleBlocEvent extends FavoriteEvent {
  const GetAllFavoritePeopleBlocEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoritePeopleIdBlocEvent extends FavoriteEvent {
  final int id;

  const DeleteFavoritePeopleIdBlocEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchFavoritePeopleIdBlocEvent extends FavoriteEvent {
  final String? keyword;

  const SearchFavoritePeopleIdBlocEvent({required this.keyword});

  @override
  List<Object> get props => [];
}