import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:sw_finder/features/strarship/data/models/starship_model.dart';

abstract class StarshipLocalDataSource {
  Future<void> init();

  void addStarship(StarshipModel starshipModel);

  List<StarshipModel> getAllStarship();

  void deleteStarshipId(int id);

  void deleteAllStarship();

  void updateStarship(StarshipModel starshipModel);
}

class StarshipLocalDataSourceImpl implements StarshipLocalDataSource {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_height TEXT,'
      '$_mass TEXT,'
      '$_hairColor TEXT,'
      '$_skinColor TEXT,'
      '$_eyeColor TEXT,'
      '$_birthYear TEXT,'
      '$_gender TEXT,'
      '$_homeworld TEXT,'
      '$_films TEXT,'
      '$_vehicles TEXT,'
      '$_starships TEXT,'
      '$_species TEXT,'
      '$_url TEXT,'
      '$_image TEXT)';
  static const String _tableName = 'starships';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _height = 'height';
  static const String _mass = 'mass';
  static const String _hairColor = 'hairColor';
  static const String _skinColor = 'skinColor';
  static const String _eyeColor = 'eyeColor';
  static const String _birthYear = 'birthDay';
  static const String _gender = 'gender';
  static const String _homeworld = 'homeworld';
  static const String _films = 'films';
  static const String _vehicles = 'vehicles';
  static const String _starships = 'starships';
  static const String _species = 'species';
  static const String _url = 'url';
  static const String _image = 'image';

  @override
  Future<void> init() async {
    final applicationDocumentDir =
    await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(StarshipModelAdapter());

    await Hive.openBox<StarshipModel>(_tableName);
  }

  @override
  void addStarship(StarshipModel starshipModel) {
    Hive.box<StarshipModel>(_tableName).add(starshipModel);
  }

  @override
  void deleteAllStarship() {
    Hive.box<StarshipModel>(_tableName).clear();
  }

  @override
  void deleteStarshipId(int id)  {
    final list = Hive.box<StarshipModel>(_tableName).values.toList();
    for(int i = 0; i < list.length; i++) {
       if (id == int.parse(list[i].id.toString())) {
         Hive.box<StarshipModel>(_tableName).deleteAt(i);
         return;
       }
    }
  }

  @override
  List<StarshipModel> getAllStarship() {
    return Hive.box<StarshipModel>(_tableName).values.toList();
  }

  @override
  void updateStarship(StarshipModel starshipModel) {
    Hive.box<StarshipModel>(_tableName).putAt(int.parse(starshipModel.id.toString()), starshipModel);
  }
}
