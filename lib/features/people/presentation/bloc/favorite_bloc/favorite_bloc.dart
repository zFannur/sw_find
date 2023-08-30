import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/domain/usecases/favorite_people.dart';
import 'package:sw_finder/core/errors/failures.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

const String cacheFailureMessage = 'Cache Failure';
const String invalidFailureInputMessage = 'Invalid Input';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePeople favoritePeople;
  List<String> listPerson = [];

  FavoriteBloc(this.favoritePeople) : super(EmptyState()) {
    on<GetAllFavoritePeopleBlocEvent>(_onGetAllFavoritePeopleBlocEvent);
    on<AddFavoritePeopleBlocEvent>(_onAddFavoritePeopleBlocEvent);
    on<DeleteFavoritePeopleIdBlocEvent>(_onDeleteFavoritePeopleIdBlocEvent);
  }

  _onGetAllFavoritePeopleBlocEvent(
      GetAllFavoritePeopleBlocEvent event, Emitter<FavoriteState> emit) {
    emit(LoadingState());
    List<Person> list = [];

    try {
      list = favoritePeople.getAllPerson();
      emit(LoadedState(listOfFavoritePeople: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onAddFavoritePeopleBlocEvent(
      AddFavoritePeopleBlocEvent event, Emitter<FavoriteState> emit) {
    List<Person> list = [];
    emit(LoadingState());

    try {
      favoritePeople.addPerson(event.person);
      list = favoritePeople.getAllPerson();
      emit(LoadedState(listOfFavoritePeople: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onDeleteFavoritePeopleIdBlocEvent(
      DeleteFavoritePeopleIdBlocEvent event, Emitter<FavoriteState> emit) {
    List<Person> list = [];
    emit(LoadingState());

    try {
      favoritePeople.deletePersonId(event.id);
      list = favoritePeople.getAllPerson();
      emit(LoadedState(listOfFavoritePeople: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
