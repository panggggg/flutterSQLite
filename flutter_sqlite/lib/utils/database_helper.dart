import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static Database _db;
  DatabaseHelper.internal();
  final _lock = new Lock();

  String sqlCreate = '''
  create table if not exists members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    telephone TEXT)
    ''';

  Future<Database> getDb() async {
    if (_db == null) {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();

      String path = join(documentDirectory.path, 'mymembers.db');
      print(path);

      await _lock.synchronized(() async {
        if(_db == null){
          _db = await openDatabase(path, version: 1);
        }
      });
    }
    return _db;
  }

  Future saveData(Map member) async {
    var dbClient = await getDb();
    String sqlInsert = '''
    INSERT INTO members(first_name, last_name, email, telephone)
    VALUES(?, ?, ?, ?)
    ''';

    await dbClient.rawQuery(sqlInsert, [
      member['firstName'],
      member['lastName'],
      member['email'],
      member['telephone'],

  ]);
    print("ข้อมูลบันทึกเรียบร้อย");
}

  Future getList() async {
    var dbClient = await getDb();
    String sqlSelect = '''
    SELECT * from members;
    ''';

    return await dbClient.rawQuery(sqlSelect);

  }

  Future remove(int id) async {
    var dbClient = await getDb();
    var sqlRemove = '''
    DELETE FROM members WHERE id=?
    ''';
    return await dbClient.rawQuery(sqlRemove, [id]);
  }

  Future initDatabase() async {
    var dbClient = await getDb();

    await dbClient.rawQuery(sqlCreate);
    print('ตารางถูกสร้างเรียบร้อย');
  }
}

