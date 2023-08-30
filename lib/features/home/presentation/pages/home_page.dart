import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/features/navigation/navgation.dart';
import 'package:sw_finder/features/people/presentation/pages/person_list.dart';
import 'package:sw_finder/features/home/presentation/drawer/my_drawer.dart';
import 'package:sw_finder/features/strarship/presentation/pages/starship_list.dart';

import '../../../strarship/presentation/bloc/starship_bloc/starship_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  Timer? searchDebounce;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: TextField(
            controller: _textEditingController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search Name',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: (value) {
              searchDebounce?.cancel();
              searchDebounce = Timer(const Duration(milliseconds: 2000), () {
                if (value.length >= 2) {
                  context.read<StarshipBloc>().page = 1;
                  context.read<StarshipBloc>().isSearch = true;
                  //starshipList.clear();
                  context.read<StarshipBloc>().add(
                      SearchStarshipBlocEvent(name: _textEditingController.text));
                } else if (value.isEmpty){
                  context.read<StarshipBloc>().page = 1;
                  context.read<StarshipBloc>().isSearch = false;
                  context
                      .read<StarshipBloc>()
                      .add(SearchStarshipBlocEvent(name: ''));
                }
              });
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.favorite);
                },
                icon: const Icon(Icons.favorite, color: Colors.red)),
          ],
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
        body: TabBarView(
          children: [
            StarshipList(text: _textEditingController.text),
            PersonList(text: _textEditingController.text),
          ],
        ),
      ),
    );
  }
}
