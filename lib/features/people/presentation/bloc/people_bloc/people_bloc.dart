import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/core/errors/failures.dart';
import 'package:sw_finder/features/people/domain/usecases/search_people.dart';

part 'people_event.dart';
part 'people_state.dart';

const String serverFailureMessage = 'Server Failure';
const String invalidFailureInputMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final SearchPeople searchPeople;
  int page = 1;
  bool isFetching = false;
  bool isSearch = false;
  List<Person> favoritePerson = [];

  PeopleBloc({required this.searchPeople}) : super(Empty()) {
    on<SearchPeopleBlocEvent>(_onSearchPeopleBlocEvent);
  }

  _onSearchPeopleBlocEvent(
      SearchPeopleBlocEvent event, Emitter<PeopleState> emit) async {
    emit(Loading());
    List<Person> personList = [];

    try {
      personList = await searchPeople(Query(name: event.name, pageNumber: page++));
      emit(Loaded(listOfPeople: personList));
    } on InvalidTextError {
      emit(Error(message: invalidFailureInputMessage));
    } on ServerFailure {
      emit(Error(message: serverFailureMessage));
    } catch (e) {
      page = 1;
      emit(Error(message: e.toString()));
    }
  }
}