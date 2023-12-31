import 'package:flutter/material.dart';

import 'package:sw_finder/features/people/domain/entities/person.dart';
import 'package:sw_finder/core/utils/components/utils.dart';

class PersonDetail extends StatelessWidget {
  final Person person;

  const PersonDetail({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              person.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(),
                  child: SizedBox(
                    width: double.infinity,
                    height: Utils().screenSafeAreaHeight(context),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 35,
                            child: Image.asset(
                              person.image!,
                            ),
                          ),
                          Expanded(
                            flex: 65,
                            child: SingleChildScrollView(
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.black26,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4, top: 15, bottom: 0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 5),
                                        child:
                                            _centerRow("Name : ", person.name!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 20),
                                        child: _centerRow(
                                            "Home World : ", person.homeworld!),
                                      ),
                                      _threeDataRow(
                                          "Birth Year",
                                          person.birthYear!,
                                          "Height",
                                          person.height!,
                                          "Mass",
                                          person.mass!),
                                      _threeDataRow(
                                          "Gender",
                                          person.gender!,
                                          "Skin Color",
                                          person.skinColor!,
                                          "Eye Color",
                                          person.eyeColor!),
                                      _listRow("Films : ", person.films!),
                                      _listRow("Species : ", person.species!),
                                      _listRow(
                                          "Starships : ", person.starships!),
                                      _listRow("Vehicles : ", person.vehicles!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
    );
  }

  Row _centerRow(String description, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 3.0,
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Padding _threeDataRow(
      String firstDescription,
      String firstData,
      String secondDescription,
      String secondData,
      String thirdDescription,
      String thirdData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: Row(
        children: <Widget>[
          _threeDataRowColumn(firstDescription, firstData),
          _threeDataRowColumn(secondDescription, secondData),
          _threeDataRowColumn(thirdDescription, thirdData),
        ],
      ),
    );
  }

  Expanded _threeDataRowColumn(String description, String data) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Padding _listRow(String description, List<String> data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 3.0,
          ),
          Text(
            Utils().prepareLists(data),
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

}
