import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/presentation/bloc/people_bloc/people_bloc.dart';
import 'package:sw_finder/core/utils/components/progress.dart';
import 'package:sw_finder/features/people/presentation/widgets/loaded_list.dart';
import 'package:sw_finder/core/utils/components/connection_error.dart';

class PersonList extends StatefulWidget {
  final String? text;
  const PersonList({super.key, required this.text});

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
    return Column(
      children: [
        BlocConsumer<PeopleBloc, PeopleState>(
          listener: (context, state) {
            if (state is Empty) {
              context
                  .read<PeopleBloc>()
                  .add(SearchPeopleBlocEvent(name: _textEditingController.text));
            }
            if (state is Loading && context.read<PeopleBloc>().isSearch) {
              personList.clear();
            }
            if (state is Loading && !context.read<PeopleBloc>().isSearch && (widget.text?.isEmpty ?? true) && context.read<PeopleBloc>().page == 1) {
              personList.clear();
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
    );
  }
}
