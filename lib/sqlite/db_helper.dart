import 'dart:async';
import 'dart:io' as io;

import '../models/user_information.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String EMAIL = 'email';
  static const String PHONE = 'phone';
  static const String DATEOFBIRTH = 'dateOfBirth';
  static const String PASSWORD = 'password';
  static const String TABLE = 'user_information';
  static const String DB_NAME = 'blog.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTEGER PIRMARY KEY, $NAME TEXT, $EMAIL TEXT, $PHONE TEXT, $DATEOFBIRTH TEXT, $PASSWORD TEXT)");
  }

  Future<UserInformation> save(UserInformation userInformation) async {
    var dbClient = await db;
    // userInformation.id = await dbClient.insert(TABLE, employee.toMap());
    //return userInformation;
    await dbClient.transaction((tnx) async {
      var query =
          "INSERT INTO $TABLE ($NAME, $EMAIL, $PHONE, $DATEOFBIRTH, $PASSWORD) VALUES('" +
              userInformation.name +
              "', '" +
              userInformation.email +
              "','" +
              userInformation.phone +
              "','" +
              userInformation.dateOfBirth +
              "','" +
              userInformation.password +
              "')";
      return await tnx.rawInsert(query);
    },
    );
    return userInformation;
  }
}
