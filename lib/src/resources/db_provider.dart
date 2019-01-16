import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/item_model.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'resources.dart';

class DbProvider implements Source, Cache{
  Database db;

  DbProvider() {
    init();
  }

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'items14.db');
    db = await openDatabase(path, version: 1,
      onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE Items
        (
        id INTEGER PRIMARY KEY,
        deleted INTEGER, 
        type TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        dead INTEGER, 
        parent INTEGER,
        kids BLOB,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
        )
        """);
    });
  }


  Future<ItemModel> fetchOne(int id) async {
    return await db.query('Items', columns: null, where: 'id = ?', whereArgs: [id])
    .then((List<Map<String, dynamic>> onValue){
      //(onValue.length>0) ? print(onValue[0]): print('nulll');
      return (onValue.length>0) ? ItemModel.fromDb(onValue[0]) : null;
    });
    
      
  }


  saveOneId(ItemModel item) {
    db.insert(
      'Items', 
      item.toMapForDb()
      , conflictAlgorithm: ConflictAlgorithm.ignore);
    //print(item.toMapForDb());
  }

  clearAll() async{
    await db.delete('Items');
  }

  fetchTopIds() {
    return null;
  }

}

final dbProvider = DbProvider();
