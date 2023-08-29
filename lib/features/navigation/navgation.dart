import 'package:flutter/material.dart';
import 'navigation_bar_screen.dart';

class RouteNames {
  static String navigationBar = '/';
}

class Navigation {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      RouteNames.navigationBar: (context) => const NavigationBottomBarScreen(),
    };
  }
}