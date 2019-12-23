import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

//Just used for sqflite 

class DBUtils{
  static Future<Database> init() async {
    return openDatabase(
      path.join(await getDatabasesPath(), 'user_items.db'),
      onCreate: (db, version) {
        if (version > 1) {
          // downgrade path
        }
        db.execute('CREATE TABLE user_items(id INTEGER PRIMARY KEY, userName TEXT, email TEXT, age INT)');
      },
      version: 1,
    );
  }
}