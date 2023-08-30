import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sw_finder/features/people/data/datasources/people_local_datasource.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'sw_find.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(PeopleLocalDataSourceImpl.tableSql);
  }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
}
