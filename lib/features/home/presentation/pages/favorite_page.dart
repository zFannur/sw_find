import 'package:flutter/material.dart';

import '../../../people/presentation/pages/favorite_people_page.dart';
import '../../../strarship/presentation/pages/favorite_starship_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.rocket),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Column(
              children: [
                FavoriteStarshipPage(),
              ],
            ),
            Column(
              children: [
                FavoritePersonPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
