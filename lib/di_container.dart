import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sw_finder/features/people/domain/usecases/favorite_people.dart';
import 'package:sw_finder/features/people/domain/usecases/search_people.dart';
import 'package:sw_finder/features/people/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:sw_finder/features/strarship/domain/usecases/get_starship.dart';
import 'bloc_observable.dart';
import 'core/network/network_info.dart';
import 'features/people/data/datasources/people_local_datasource.dart';
import 'features/people/data/datasources/people_remote_datasource.dart';
import 'features/people/data/repositories/people_repository_impl.dart';
import 'features/people/domain/repositories/people_repository.dart';
import 'features/people/domain/usecases/get_people.dart';
import 'features/people/presentation/bloc/people_bloc/people_bloc.dart';
import 'package:http/http.dart';

import 'features/strarship/data/datasources/starship_local_datasource.dart';
import 'features/strarship/data/datasources/starship_remote_datasource.dart';
import 'features/strarship/data/repositories/starship_repository_impl.dart';
import 'features/strarship/domain/repositories/starship_repository.dart';
import 'features/strarship/domain/usecases/favorite_starship.dart';
import 'features/strarship/domain/usecases/search_starship.dart';
import 'features/strarship/presentation/bloc/favorite_starship_bloc/favorite_starship_bloc.dart';
import 'features/strarship/presentation/bloc/starship_bloc/starship_bloc.dart';

class DiContainer {
  GetIt sl = GetIt.instance;

  Future<void> init() async {
    Bloc.observer = CharacterBlocObservable();

    //external------------------------------------------------------------------

    sl.registerLazySingleton<Client>(() => Client());
    sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());

    //core--------------------------------------------------------------------

    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
          sl(),
        ));

    //data source---------------------------------------------------------------

    //People
    sl.registerLazySingleton<PeopleRemoteDataSource>(
      () => PeopleRemoteDataSourceImpl(client: sl<Client>()),
    );
    sl.registerLazySingleton<PeopleLocalDataSource>(
      () => PeopleLocalDataSourceImpl(),
    );
    PeopleLocalDataSource localRepository = sl<PeopleLocalDataSource>();
    await localRepository.init();
    //Starship
    sl.registerLazySingleton<StarshipRemoteDataSource>(
          () => StarshipRemoteDataSourceImpl(client: sl<Client>()),
    );
    sl.registerLazySingleton<StarshipLocalDataSource>(
          () => StarshipLocalDataSourceImpl(),
    );
    StarshipLocalDataSource localStarshipRepository = sl<StarshipLocalDataSource>();
    await localStarshipRepository.init();

    //repository----------------------------------------------------------------

    //People
    sl.registerLazySingleton<PeopleRepository>(
          () => PeopleRepositoryImpl(
        peopleLocalDataSource: sl<PeopleLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        peopleRemoteDataSource: sl<PeopleRemoteDataSource>(),
      ),
    );
    //Starship
    sl.registerLazySingleton<StarshipRepository>(
      () => StarshipRepositoryImpl(
        starshipLocalDataSource: sl<StarshipLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        starshipRemoteDataSource: sl<StarshipRemoteDataSource>(),
      ),
    );

    //domain--------------------------------------------------------------------

    //People
    sl.registerLazySingleton<GetPeople>(
        () => GetPeople(sl<PeopleRepository>()));
    sl.registerLazySingleton<SearchPeople>(
        () => SearchPeople(sl<PeopleRepository>()));
    sl.registerLazySingleton<FavoritePeople>(
        () => FavoritePeople(sl<PeopleRepository>()));
    //Starship
    sl.registerLazySingleton<GetStarship>(
            () => GetStarship(sl<StarshipRepository>()));
    sl.registerLazySingleton<SearchStarship>(
            () => SearchStarship(sl<StarshipRepository>()));
    sl.registerLazySingleton<FavoriteStarship>(
            () => FavoriteStarship(sl<StarshipRepository>()));

    //presentation--------------------------------------------------------------

    //bloc
    sl.registerSingleton<PeopleBloc>(PeopleBloc(
      searchPeople: sl<SearchPeople>(),
    ));
    sl.registerSingleton<FavoriteBloc>(FavoriteBloc(sl<FavoritePeople>()));

    sl.registerSingleton<StarshipBloc>(StarshipBloc(
      searchStarship: sl<SearchStarship>(),
    ));
    sl.registerSingleton<FavoriteStarshipBloc>(FavoriteStarshipBloc(sl<FavoriteStarship>()));
  }
}
