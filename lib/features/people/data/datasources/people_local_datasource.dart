import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sw_finder/features/people/data/models/people_model.dart';

abstract class PeopleLocalDataSource {
  Future<void> init();

  void addPerson(PersonModel person);

  List<PersonModel> getAllPerson();

  void deletePersonId(int id);

  void deleteAllPerson();

  void updatePerson(PersonModel person);
}

class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
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
  static const String _tableName = 'people';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _height = 'height';
  static const String _mass = 'mass';
  static const String _hairColor = 'hairColor';
  static const String _skinColor = 'skinColor';
  static const String _eyeColor = 'eyeColor';
  static const String _birthYear = 'birthYear';
  static const String _gender = 'gender';
  static const String _homeworld = 'homeworld';
  static const String _films = 'films';
  static const String _vehicles = 'vehicles';
  static const String _starships = 'starships';
  static const String _species = 'species';
  static const String _url = 'url';
  static const String _image = 'image';

  // static final PeopleLocalDataSourceImpl db = PeopleLocalDataSourceImpl();
  // Database? _database;
  //
  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await initDB();
  //   return _database!;
  // }
  //
  // Future<Database> initDB() async {
  //   Directory documentsDirectory = await getApplicationSupportDirectory();
  //   String path = join(documentsDirectory.path, "$_tableName.db");
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onOpen: (db) {},
  //     onCreate: (Database db, int version) async {
  //       await db.execute(tableSql);
  //     },
  //   );
  // }
  //
  // @override
  // Future<PersonModel> addPerson(PersonModel personModel) async {
  //   final db = await database;
  //   int id = int.parse(personModel.id.toString());
  //   id = await db.insert(_tableName, personModel.toMap());
  //   return personModel;
  // }
  //
  // @override
  // Future<List<PersonModel>> getAllPerson() async {
  //   final db = await database;
  //   List<Map<String, dynamic>> res = await db.query(_tableName);
  //   List<PersonModel> list =
  //       res.isNotEmpty ? res.map((e) => PersonModel.fromMap(e)).toList() : [];
  //   list.addAll(list);
  //   return list;
  // }
  //
  // @override
  // Future<Future<int>> deletePersonId(int id) async {
  //   final db = await database;
  //   return db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  // }
  //
  // @override
  // Future<Future<int>> deleteAllPerson() async {
  //   final db = await database;
  //   return db.rawDelete("Delete FROM $_tableName");
  // }
  //
  // Future<void> deleteDatabase(String path) =>
  //     databaseFactory.deleteDatabase(path);
  //
  // @override
  // Future<int> updatePerson(PersonModel personModel) async {
  //   final db = await database;
  //   var res = await db.update(
  //     _tableName,
  //     personModel.toMap(),
  //     where: "id =?",
  //     whereArgs: [personModel.id],
  //   );
  //   return res;
  // }
  //
  // @override
  // Future<List<PersonModel>> searchPerson(String keyword) async {
  //   final db = await database;
  //   List<Map<String, dynamic>> result = await db
  //       .rawQuery("SELECT * FROM $_tableName WHERE title = ?", [keyword]);
  //   List<PersonModel> list =
  //       result.map((e) => PersonModel.fromJson(e)).toList();
  //   return list;
  // }

  @override
  Future<void> init() async {
    final applicationDocumentDir =
    await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(PersonModelAdapter());

    await Hive.openBox<PersonModel>(_tableName);
  }

  @override
  void addPerson(PersonModel person) {
    Hive.box<PersonModel>(_tableName).add(person);
  }

  @override
  void deleteAllPerson() {
    Hive.box<PersonModel>(_tableName).clear();
  }

  @override
  void deletePersonId(int id)  {
    final list = Hive.box<PersonModel>(_tableName).values.toList();
    for(int i = 0; i < list.length; i++) {
       if (id == int.parse(list[i].id.toString())) {
         Hive.box<PersonModel>(_tableName).deleteAt(i);
         return;
       }
    }
  }

  @override
  List<PersonModel> getAllPerson() {
    return Hive.box<PersonModel>(_tableName).values.toList();
  }

  @override
  void updatePerson(PersonModel person) {
    Hive.box<PersonModel>(_tableName).putAt(int.parse(person.id.toString()), person);
  }
}
