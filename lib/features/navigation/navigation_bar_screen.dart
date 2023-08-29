import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sw_finder/resource/langs/locale_keys.g.dart';
import 'package:sw_finder/features/presentation/pages/favorite_page.dart';
import 'package:sw_finder/features/presentation/pages/home_page.dart';

class NavigationBottomBarScreen extends StatefulWidget {
  const NavigationBottomBarScreen({super.key});

  @override
  State<NavigationBottomBarScreen> createState() => _NavigationBottomBarScreenState();
}

class _NavigationBottomBarScreenState extends State<NavigationBottomBarScreen> {
  int _currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: LocaleKeys.homeTitle.tr(),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.favorite),
            icon: const Icon(Icons.favorite_outline),
            label: LocaleKeys.favoriteTitle.tr(),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentPageIndex,
          children: [
            HomePage(key: UniqueKey()),
            FavoritePage(key: UniqueKey()),
          ],
        ),
      ),
    );
  }
}