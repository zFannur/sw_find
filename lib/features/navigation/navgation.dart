import 'package:flutter/material.dart';
import 'package:sw_finder/features/home/presentation/pages/favorite_page.dart';
import 'package:sw_finder/features/home/presentation/pages/home_page.dart';

class RouteNames {
  static String home = '/';
  static String favorite = '/favorite';
}

class Navigation {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      RouteNames.home: (context) => const HomePage(),
      RouteNames.favorite: (context) => const FavoritePage(),
    };
  }
}