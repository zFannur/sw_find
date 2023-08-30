import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/core/errors/failures.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/usecases/search_starship.dart';

part 'starship_event.dart';
part 'starship_state.dart';

const String serverFailureMessage = 'Server Failure';
const String invalidFailureInputMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class StarshipBloc extends Bloc<StarshipEvent, StarshipState> {
  final SearchStarship searchStarship;
  int page = 1;
  bool isFetching = false;
  bool isSearch = false;
  List<Starship> favoriteStarship = [];

  StarshipBloc({required this.searchStarship}) : super(Empty()) {
    on<SearchStarshipBlocEvent>(_onSearchStarshipBlocEvent);
  }

  _onSearchStarshipBlocEvent(
      SearchStarshipBlocEvent event, Emitter<StarshipState> emit) async {
    emit(Loading());
    List<Starship> list = [];

    try {
      list = await searchStarship(Query(name: event.name, pageNumber: page++));
      emit(Loaded(listOfStarship: list));
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