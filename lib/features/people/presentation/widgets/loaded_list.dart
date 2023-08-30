import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sw_finder/core/utils/components/utils.dart';
import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/features/people/domain/usecases/favorite_people.dart';
import 'package:sw_finder/features/people/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:sw_finder/features/people/presentation/pages/person_detail.dart';

class LoadedList extends StatefulWidget {

  const LoadedList({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  State<LoadedList> createState() => _LoadedListState();
}

class _LoadedListState extends State<LoadedList> {
  final favoritePeople = GetIt.instance<FavoritePeople>();

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
              builder: (context) => PersonDetail(person: widget.person),
            ),
          )
        },
        //Utils().randomColor()
        child: Container(
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
                borderRadius: Utils().buildBorderRadius(),
                color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Image.asset(widget.person.image!),
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
                          child: Text(widget.person.name!,
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
                          child: Text(widget.person.gender!,
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
                          child: Text(widget.person.starships!.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                              textAlign: TextAlign.start),
                        ),
                        IconButton(
                          onPressed: () {
                            if (favoritePeople.getFavoriteId.contains(widget.person.id.toString())) {
                              context.read<FavoriteBloc>().add(
                                  DeleteFavoritePeopleIdBlocEvent(
                                      id: int.parse(widget.person.id.toString())));
                            } else {
                              context.read<FavoriteBloc>().add(
                                  AddFavoritePeopleBlocEvent(person: widget.person));
                            }
                            setState(() {});
                          },
                          icon: favoritePeople.getFavoriteId.contains(widget.person.id.toString())
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_outline, color: Colors.red),
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
