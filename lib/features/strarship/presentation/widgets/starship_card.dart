import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sw_finder/core/utils/components/utils.dart';

import 'package:sw_finder/features/strarship/domain/entities/starship.dart';
import 'package:sw_finder/features/strarship/domain/usecases/favorite_starship.dart';
import 'package:sw_finder/features/strarship/presentation/bloc/favorite_starship_bloc/favorite_starship_bloc.dart';
import 'package:sw_finder/features/strarship/presentation/pages/starship_detail.dart';

class LoadedCard extends StatefulWidget {

  const LoadedCard({
    Key? key,
    required this.starship,
  }) : super(key: key);

  final Starship starship;

  @override
  State<LoadedCard> createState() => _LoadedCardState();
}

class _LoadedCardState extends State<LoadedCard> {
  final favoriteStarship = GetIt.instance<FavoriteStarship>();

  List<String> favoriteList = [];

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: Utils().buildBorderRadius(),
      ),
      child: InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StarshipDetail(starship: widget.starship),
            ),
          )
        },
        //Utils().randomColor()
        child: Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                borderRadius: Utils().buildBorderRadius(),
                color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Image.asset(widget.starship.image!),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: Colors.black38,
                          height: 30,
                          width: double.infinity,
                          child: Text(widget.starship.name!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              textAlign: TextAlign.start),
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.black38,
                          height: 30,
                          width: double.infinity,
                          child: Text(widget.starship.model!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              textAlign: TextAlign.start),
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.black38,
                          height: 30,
                          width: double.infinity,
                          child: Text(widget.starship.manufacturer!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              textAlign: TextAlign.start),
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.black38,
                          height: 30,
                          width: double.infinity,
                          child: Text(widget.starship.crew!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              textAlign: TextAlign.start),
                        ),
                        SizedBox(
                          height: 30,
                          child: IconButton(
                            onPressed: () {
                              if (favoriteStarship.getFavoriteId.contains(widget.starship.id.toString())) {
                                context.read<FavoriteStarshipBloc>().add(
                                    DeleteFavoriteStarshipIdBlocEvent(
                                        id: int.parse(widget.starship.id.toString())));
                              } else {
                                context.read<FavoriteStarshipBloc>().add(
                                    AddFavoriteStarshipBlocEvent(starship: widget.starship));
                              }
                              setState(() {});
                            },
                            icon: favoriteStarship.getFavoriteId.contains(widget.starship.id.toString())
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_outline, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
