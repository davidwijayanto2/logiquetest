import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _database;
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database ?? await createDatabase();

    _database = await createDatabase();
    return _database ?? await createDatabase();
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbpath = join(documentsDirectory.path, "dbsocialmedia");
    print('dbpath: ' + dbpath);
    return await openDatabase(dbpath, version: 1, onCreate: populateDb);
  }

  void populateDb(Database database, int version) async {
    await database.execute('''
          CREATE TABLE friend (
            idfriend INTEGER PRIMARY KEY AUTOINCREMENT,
            id TEXT            
            )''');
  }
}
