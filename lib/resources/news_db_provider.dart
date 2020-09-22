import 'dart:async';
import 'dart:io';
import 'package:flutter_animation/model/item_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider {
  Database db;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "items.db");
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    String sql = """ 
    CREATE TABLE Items(
    id INTEGER PRIMARY KEY,
    type TEXT,
    by TEXT,
    time INTEGER,
    text TEXT,
    parent INTEGER,
    kids BLOB,
    dead INTEGER,
    deleted Integer,
    url TEXT,
    score INTEGER,
    title TEXT,
    descendants INTEGER
    ) 
    """;
    db.execute(sql);
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel model) {
    return db.insert("Items", model.toMap());
  }
}
