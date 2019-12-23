import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'user_SQFLITE.dart';
//import 'package:lab045/grades.dart';

class GradesModel {
  //For Inserting into the database
  Future<int> insertUsers(User users) async {
    final db = await DBUtils.init();
    return await db.insert(
      'user_items',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //For updating Grades in the database
  Future<int> updateUsers(User users) async {
    final db = await DBUtils.init();
    return await db.update('user_items', users.toMap(),
        where: 'userName = ?', whereArgs: [users.userName]);
  }

  //For deleteing A student in the databse
  Future<int> deleteUsers(int id) async {
    final db = await DBUtils.init();
    return await db.delete(
      'user_items',
      where: 'userName = ?',
      whereArgs: [id],
    );
  }

  //Getting all the grades
  Future<List<User>> getAllUsers() async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query('user_items');
    List<User> users = [];
    for (int x = 0; x < maps.length; x++) {
      users.add(User.fromMap(maps[x]));
    }
    return users;
  }

  //Getting a certain student
  Future<User> getUsersWithId(int id) async {
    final db = await DBUtils.init();
    List<Map<String, dynamic>> maps = await db.query(
      'user_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return User.fromMap(maps[0]);
    } else {
      return null;
    }
  }
}
