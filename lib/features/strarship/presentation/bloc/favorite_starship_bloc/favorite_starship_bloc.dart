import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/core/errors/failures.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/usecases/favorite_starship.dart';

part 'favorite_starship_event.dart';
part 'favorite_starship_state.dart';

const String cacheFailureMessage = 'Cache Failure';
const String invalidFailureInputMessage = 'Invalid Input';

class FavoriteStarshipBloc extends Bloc<FavoriteStarshipEvent, FavoriteStarshipState> {
  final FavoriteStarship favoriteStarship;
  List<String> listStarship = [];

  FavoriteStarshipBloc(this.favoriteStarship) : super(EmptyState()) {
    on<GetAllFavoriteStarshipBlocEvent>(_onGetAllFavoriteStarshipBlocEvent);
    on<AddFavoriteStarshipBlocEvent>(_onAddFavoriteStarshipBlocEvent);
    on<DeleteFavoriteStarshipIdBlocEvent>(_onDeleteFavoriteStarshipIdBlocEvent);
  }

  _onGetAllFavoriteStarshipBlocEvent(
      GetAllFavoriteStarshipBlocEvent event, Emitter<FavoriteStarshipState> emit) {
    emit(LoadingState());
    List<Starship> list = [];

    try {
      list = favoriteStarship.getAllStarship();
      emit(LoadedState(listOfFavoriteStarship: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onAddFavoriteStarshipBlocEvent(
      AddFavoriteStarshipBlocEvent event, Emitter<FavoriteStarshipState> emit) {
    List<Starship> list = [];
    emit(LoadingState());

    try {
      favoriteStarship.addStarship(event.starship);
      list = favoriteStarship.getAllStarship();
      emit(LoadedState(listOfFavoriteStarship: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onDeleteFavoriteStarshipIdBlocEvent(
      DeleteFavoriteStarshipIdBlocEvent event, Emitter<FavoriteStarshipState> emit) {
    List<Starship> list = [];
    emit(LoadingState());

    try {
      favoriteStarship.deleteStarshipId(event.id);
      list = favoriteStarship.getAllStarship();
      emit(LoadedState(listOfFavoriteStarship: list));
    } on InvalidTextError {
      emit(ErrorState(message: invalidFailureInputMessage));
    } on CacheFailure {
      emit(ErrorState(message: cacheFailureMessage));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
