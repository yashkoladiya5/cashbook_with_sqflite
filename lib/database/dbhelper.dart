import 'dart:io';

import 'package:cashbook_with_sqflite/model/transaction_model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

const String historyTB = "HistoryTB";

class DBhelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "my.db");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $historyTB(username TEXT,finalAmount INT,cashInAmount INT,cashOutAmount INT,date String,time String)');
      },
    );
    return _database;
  }

  Future<UserModel> insertHistoryData(UserModel userModel) async {
    Database? db = await database;
    await db!.insert(historyTB, userModel.toJson());
    return userModel;
  }

  Future<List<UserModel>> getHistoryDataByUser(String username) async {
    Database? db = await database;
    var result = await db!.rawQuery(
        'SELECT * FROM $historyTB WHERE username = ? AND finalAmount IS NOT null',
        [username]);
    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<List<dynamic>> getTotalBalanceOfUser() async {
    Database? db = await database;
    var result = await db!.rawQuery(
        'SELECT username,sum(cashInAmount)-sum(cashOutAmount) as totalAmount FROM $historyTB GROUP BY username');
    return result.toList();
  }
}
