part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchPeopleBlocEvent extends PeopleEvent {
  final String? name;

  SearchPeopleBlocEvent({required this.name});

  @override
  List<Object> get props => [];
}
