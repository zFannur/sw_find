import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sw_finder/features/people/domain/usecases/favorite_people.dart';
import 'package:sw_finder/features/people/domain/usecases/search_people.dart';
import 'package:sw_finder/features/people/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'bloc_observable.dart';
import 'core/network/network_info.dart';
import 'features/people/data/datasources/people_local_datasource.dart';
import 'features/people/data/datasources/people_remote_datasource.dart';
import 'features/people/data/repositories/people_repository_impl.dart';
import 'features/people/domain/repositories/people_repository.dart';
import 'features/people/domain/usecases/get_people.dart';
import 'features/people/presentation/bloc/people_bloc/people_bloc.dart';
import 'package:http/http.dart';

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

    //Films
    // getIt.registerLazySingleton<FilmsRemoteDataSource>(
    //       () => FilmsRemoteDataSourceImpl(client: sl()),
    // );
    // sl.registerLazySingleton<FilmsLocalDataSource>(
    //       () => FilmsLocalDataSourceImpl(),
    // );
    //People
    sl.registerLazySingleton<PeopleRemoteDataSource>(
      () => PeopleRemoteDataSourceImpl(client: sl<Client>()),
    );
    sl.registerLazySingleton<PeopleLocalDataSource>(
      () => PeopleLocalDataSourceImpl(),
    );

    PeopleLocalDataSource localRepository = sl<PeopleLocalDataSource>();
    await localRepository.init();
    //Planets
    // sl.registerLazySingleton<PlanetsRemoteDataSource>(
    //       () => PlanetsRemoteDataSourceImpl(client: sl()),
    // );
    // sl.registerLazySingleton<PlanetsLocalDataSource>(
    //       () => PlanetsLocalDataSourceImpl(),
    // );
    //Starships
    // sl.registerLazySingleton<StarshipsRemoteDataSource>(
    //       () => StarshipsRemoteDataSourceImpl(client: sl()),
    // );
    // sl.registerLazySingleton<StarshipsLocalDataSource>(
    //       () => StarshipsLocalDataSourceImpl(),
    // );

    //repository----------------------------------------------------------------

    // getIt.registerLazySingleton<FilmsRepository>(
    //       () => FilmsRepositoryImpl(
    //     filmsLocalDataSource: sl(),
    //     networkInfo: sl(),
    //     filmsRemoteDataSource: sl(),
    //   ),
    // );


    sl.registerLazySingleton<PeopleRepository>(
      () => PeopleRepositoryImpl(
        peopleLocalDataSource: sl<PeopleLocalDataSource>(),
        networkInfo: sl<NetworkInfo>(),
        peopleRemoteDataSource: sl<PeopleRemoteDataSource>(),
      ),
    );
    // getIt.registerLazySingleton<PlanetsRepository>(
    //       () => PlanetsRepositoryImpl(
    //     planetsLocalDataSource: sl(),
    //     networkInfo: sl(),
    //     planetsRemoteDataSource: sl(),
    //   ),
    // );
    // getIt.registerLazySingleton<StarshipsRepository>(
    //       () => StarshipsRepositoryImpl(
    //     starshipsLocalDataSource: sl(),
    //     networkInfo: sl(),
    //     starshipsRemoteDataSource: sl(),
    //   ),
    // );

    //domain--------------------------------------------------------------------

    //use case
    //getIt.registerLazySingleton(() => GetFilms(sl()));
    sl.registerLazySingleton<GetPeople>(
        () => GetPeople(sl<PeopleRepository>()));
    sl.registerLazySingleton<SearchPeople>(
        () => SearchPeople(sl<PeopleRepository>()));
    sl.registerLazySingleton<FavoritePeople>(
        () => FavoritePeople(sl<PeopleRepository>()));
    //getIt.registerLazySingleton(() => GetPlanets(sl()));
    //getIt.registerLazySingleton(() => GetStarships(sl()));

    //presentation--------------------------------------------------------------

    //bloc
    sl.registerSingleton<PeopleBloc>(PeopleBloc(
      searchPeople: sl<SearchPeople>(),
    ));
    sl.registerSingleton<FavoriteBloc>(FavoriteBloc(sl<FavoritePeople>()));
  }
}
