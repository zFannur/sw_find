import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/presentation/bloc/people_bloc/people_bloc.dart';
import 'package:sw_finder/core/utils/components/progress.dart';
import 'package:sw_finder/features/people/presentation/widgets/loaded_list.dart';
import 'package:sw_finder/core/utils/components/connection_error.dart';

class PersonList extends StatefulWidget {

  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  List<Person> personList = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  Timer? searchDebounce;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 16),
            child: TextField(
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
                    context.read<PeopleBloc>().page = 1;
                    personList.clear();
                    context.read<PeopleBloc>().add(
                        SearchPeopleBlocEvent(name: _textEditingController.text));
                  } else if (value.isEmpty){
                    context.read<PeopleBloc>().page = 1;
                    personList.clear();
                    context
                        .read<PeopleBloc>()
                        .add(SearchPeopleBlocEvent(name: ''));
                  }
                });
              },
            ),
          ),
          BlocConsumer<PeopleBloc, PeopleState>(
            listener: (context, state) {
              if (state is Empty) {
                context
                    .read<PeopleBloc>()
                    .add(SearchPeopleBlocEvent(name: _textEditingController.text));
              }
              if (state is Loading && personList.isNotEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('loading...')));
              } else if (state is Loaded && state.listOfPeople.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('People not find')));
              }
            },
            builder: (context, state) {
              if (state is Empty || state is Loading && personList.isEmpty) {
                return const Progress();
              } else if (state is Loaded) {
                personList.addAll(state.listOfPeople);
                context.read<PeopleBloc>().isFetching = false;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              } else if (state is Error && personList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<PeopleBloc>()
                          ..isFetching = true
                          ..add(SearchPeopleBlocEvent(
                              name: _textEditingController.text));
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                    const SizedBox(height: 15),
                    Text(state.message, textAlign: TextAlign.center),
                  ],
                );
              } else if (state is Error) {
                const ConnectionError();
              }
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !context.read<PeopleBloc>().isFetching) {
                        context.read<PeopleBloc>()
                          ..isFetching = true
                          ..add(SearchPeopleBlocEvent(
                              name: _textEditingController.text));
                      }
                    }),
                  itemBuilder: (context, index) => LoadedList(
                    person: personList[index],
                  ),
                  itemCount: personList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
