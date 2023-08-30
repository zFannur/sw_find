import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sw_finder/core/utils/components/progress.dart';
import 'package:sw_finder/core/utils/components/unknown_error.dart';
import 'package:sw_finder/features/strarship/presentation/bloc/favorite_starship_bloc/favorite_starship_bloc.dart';
import 'package:sw_finder/features/strarship/presentation/widgets/starship_card.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';

class FavoriteStarshipPage extends StatelessWidget {
  const FavoriteStarshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    late List<Starship> starshipList;

    return BlocBuilder<FavoriteStarshipBloc, FavoriteStarshipState>(
      builder: (context, state) {
        if (state is EmptyState) {
          return const SizedBox(
            height: 1,
          );
        } else if (state is LoadingState) {
          return const Progress();
        } else if (state is LoadedState) {
          starshipList = state.listOfFavoriteStarship;
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => LoadedCard(
                starship: starshipList[index],
              ),
              itemCount: starshipList.length,
            ),
          ); // Text(state.listOfPeople[3].name);
        } else if (state is ErrorState) {
          return const UnknownError();
        } else {
          return const UnknownError();
        }
      },
    );
  }
}
