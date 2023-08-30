import 'package:flutter/material.dart';
import 'package:sw_finder/features/navigation/navgation.dart';
import 'package:sw_finder/features/people/presentation/pages/person_list.dart';
import 'package:sw_finder/features/home/presentation/drawer/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.favorite);
            },
            icon: const Icon(Icons.favorite, color: Colors.red)),
      ]),
      body: const PersonList(),
    );
  }
}
