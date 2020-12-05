import 'package:path_provider/path_provider.dart';
import 'package:project_sederhana_app/model/mydata.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io' as io;
import 'dart:async';

class DBhelper {
  static final DBhelper _instance = new DBhelper.internal();
  DBhelper.internal();

  factory DBhelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "BukuPuisiku");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE mybookpuisi(id INTEGER PRIMARY KEY, title TEXT, deskripsi TEXT, karya TEXT, createDate TEXT, updateDate TEXT, sortDate TEXT)");
    print("DB Created");
  }

  Future<int> saveData(MyData myData) async {
    var dbClient = await db;
    int res = await dbClient.insert("mybookpuisi", myData.toMap());
    print("data inserted");
    return res;
  }

  Future<List<MyData>> getData() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("SELECT * FROM mybookpuisi ORDER BY sortDate DESC");
    List<MyData> listData = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new MyData(list[i]['title'], list[i]['deskripsi'], list[i]['karya'],
          list[i]['createDate'], list[i]['updateDate'], list[i]['sortDate']);
      data.setDataId(list[i]['id']);
      listData.add(data);
    }
    return listData;
  }

  Future<bool> updateData(MyData myData) async {
    var dbClient = await db;
    int res = await dbClient.update("mybookpuisi", myData.toMap(),
        where: "id=?", whereArgs: <int>[myData.id]);
    return res > 0 ? true : false;
  }

  Future<int> deleteData(MyData myData) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete("DELETE FROM mybookpuisi WHERE id=?", [myData.id]);
    return res;
  }
}
