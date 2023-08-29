import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sw_finder/features/presentation/bloc/people_bloc/people_bloc.dart';
import 'bloc_observable.dart';



class DiContainer {
  GetIt getIt = GetIt.instance;

  Future<void> init() async {
    Bloc.observer = CharacterBlocObservable();
    //data
    //domain
    //presentation
    getIt.registerSingleton(PeopleBloc());
  }
}