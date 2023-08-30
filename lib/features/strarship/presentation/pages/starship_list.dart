import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/core/utils/components/progress.dart';
import 'package:sw_finder/core/utils/components/connection_error.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/presentation/bloc/starship_bloc/starship_bloc.dart';
import 'package:sw_finder/features/strarship/presentation/widgets/starship_card.dart';

class StarshipList extends StatefulWidget {
  final String? text;

  const StarshipList({super.key, required this.text});

  @override
  State<StarshipList> createState() => _StarshipListState();
}

class _StarshipListState extends State<StarshipList> {
  List<Starship> starshipList = [];
  final ScrollController _scrollController = ScrollController();
  Timer? searchDebounce;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<StarshipBloc, StarshipState>(
          listener: (context, state) {
            if (state is Empty) {
              context
                  .read<StarshipBloc>()
                  .add(SearchStarshipBlocEvent(name: widget.text ?? ''));
            }
            if (state is Loading && context.read<StarshipBloc>().isSearch) {
              starshipList.clear();
            }
            if (state is Loading && !context.read<StarshipBloc>().isSearch && (widget.text?.isEmpty ?? true) && context.read<StarshipBloc>().page == 1) {
              starshipList.clear();
            }
            if (state is Loading && starshipList.isNotEmpty) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('loading...')));
            } else if (state is Loaded && state.listOfStarship.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starship not find')));
            }
          },
          builder: (context, state) {
            if (state is Empty || state is Loading && starshipList.isEmpty) {
              return const Progress();
            } else if (state is Loaded) {
              starshipList.addAll(state.listOfStarship);
              context.read<StarshipBloc>().isFetching = false;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } else if (state is Error && starshipList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<StarshipBloc>()
                        ..isFetching = true
                        ..add(SearchStarshipBlocEvent(
                            name: widget.text ?? ''));
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
                        !context.read<StarshipBloc>().isFetching) {
                      context.read<StarshipBloc>()
                        ..isFetching = true
                        ..add(SearchStarshipBlocEvent(
                            name: widget.text ?? ''));
                    }
                  }),
                itemBuilder: (context, index) => LoadedCard(
                  starship: starshipList[index],
                ),
                itemCount: starshipList.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
