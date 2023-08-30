part of 'starship_bloc.dart';

abstract class StarshipEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStarshipBlocEvent extends StarshipEvent {
  final String? name;

  SearchStarshipBlocEvent({required this.name});

  @override
  List<Object> get props => [];
}
