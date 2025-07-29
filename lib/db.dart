import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDp {
  static Database? _dp;

  Future<Database?> get dp async {
    if (_dp == null) {
      _dp = await startDp();
      return _dp;
    } else {
      return _dp;
    }
  }

  startDp() async {
    String databasePath = await getDatabasesPath();
    String path = join(
      databasePath,
      "namedatabase.dp",
    ); //  databasePath/namedatabase.dp

    Database database = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        log("onUpgrade");
      },
    );
    return database;
  }

  _onCreate(Database database, int version) async {
    await database.execute('''

CREATE TABLE  "name of table1"{

id INTEGER PRIMARY KEY,
 name TEXT,
  value INTEGER, 
  num REAL

}

''');

    await database.execute('''

CREATE TABLE  "name of table2"{

id INTEGER PRIMARY KEY,
 name TEXT,
  value INTEGER, 
  num REAL

}

''');
    log("database created");
  }

  readData() async {
    Database? mydatabase = await dp;
    var response = await mydatabase!.rawQuery("SELECT * FROM name of table1");
    return response;
  }

  insertData() async {
    Database? mydatabase = await dp;
    var response = await mydatabase!.rawInsert("I");
    return response;
  }

  updateData(String sql) async {
    Database? mydatabase = await dp;
    var response = await mydatabase!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydatabase = await dp;
    var response = await mydatabase!.rawDelete(sql);
    return response;
  }
}
