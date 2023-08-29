import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(PeopleInitial()) {
    on<PeopleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
