import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw_finder/features/people/presentation/bloc/favorite_bloc/favorite_bloc.dart';

import 'package:sw_finder/core/utils/components/progress.dart';
import 'package:sw_finder/core/utils/components/unknown_error.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/presentation/widgets/loaded_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    late List<Person> personList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: Column(
        children: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is EmptyState) {
                return const SizedBox(
                  height: 1,
                );
              } else if (state is LoadingState) {
                return const Progress();
              } else if (state is LoadedState) {
                personList = state.listOfFavoritePeople;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        LoadedList(
                          person: personList[index],
                        ),
                    itemCount: personList.length,
                  ),
                ); // Text(state.listOfPeople[3].name);
              } else if (state is ErrorState) {
                return const UnknownError();
              } else {
                return const UnknownError();
              }
            },
          ),
        ],
      ),
    );
  }
}