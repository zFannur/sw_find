import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sw_finder/features/strarship/domain/entities/starship.dart';

import 'core/theme/app_theme.dart';
import 'features/navigation/navgation.dart';
import 'features/people/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'features/people/presentation/bloc/people_bloc/people_bloc.dart';
import 'features/strarship/presentation/bloc/favorite_starship_bloc/favorite_starship_bloc.dart';
import 'features/strarship/presentation/bloc/starship_bloc/starship_bloc.dart';

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({Key? key, required this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) =>
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                GetIt.instance<PeopleBloc>()
                  ..add(SearchPeopleBlocEvent(name: '')),
              ),
              BlocProvider(
                create: (context) => GetIt.instance<FavoriteBloc>()
                  ..add(const GetAllFavoritePeopleBlocEvent()),
              ),
              BlocProvider(
                create: (context) =>
                GetIt.instance<StarshipBloc>()
                  ..add(SearchStarshipBlocEvent(name: '')),
              ),
              BlocProvider(
                create: (context) => GetIt.instance<FavoriteStarshipBloc>()
                  ..add(const GetAllFavoriteStarshipBlocEvent()),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: theme,
              darkTheme: darkTheme,
              initialRoute: RouteNames.home,
              routes: Navigation.routes,
            ),
          ),
    );
  }
}
