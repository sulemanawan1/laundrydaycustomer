import 'dart:developer';

import 'package:laundryday/models/carpet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'items.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE items (
        id INTEGER PRIMARY KEY,
        laundryId INTEGER,
        name TEXT,
        image TEXT,
        quantity INTEGER,
        initialCharges REAL,
        charges REAL,
        length REAL,
        prefixLength INTEGER,
        postfixLength INTEGER,
        width REAL,
        prefixWidth INTEGER,
        postfixWidth INTEGER,
        size REAL,
        category TEXT
      )''');
  }

  // Future<Items> insert(Items item) async {
  //   log(item.toJson().toString());
  //   var dbClient = await db;
  //   try {
  //     await dbClient!.insert('items', item.toJson());
  //   } on DatabaseException catch (e) {
  //     if (e.isUniqueConstraintError()) {
  //       throw UniqueConstraintException('');
  //     }
  //   } catch (e) {
  //     throw SomethingWentWrongException();
  //   }

  //   return item;
  // }

  Future<Carpet> insert(Carpet item) async {
    log(item.toJson().toString());
    var dbClient = await db;

    await dbClient!.insert('items', item.toJson());

    return item;
  }

  Future<List<Carpet>?> getItemList({required laundryId}) async {
    var dbClient = await db;
    final List<Map<String, Object?>>? queryResult = await dbClient
        ?.query('items', where: 'laundryId=?', whereArgs: [laundryId]);
    if (queryResult != null) {
      return (queryResult).map((e) => Carpet.fromJson(e)).toList();
    } else {
      return [Carpet()];
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Carpet item) async {
    var dbClient = await db;
    return await dbClient!
        .update('items', item.toJson(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> getTotalItemsCount({required laundryId}) async {
    var dbClient = await db;

    List<Map<String, dynamic>>? result = await dbClient?.query('items',
        columns: ['SUM(quantity) as total'],
        where: 'laundryId = ?',
        whereArgs: [laundryId]);

    int sum = result?.first['total'] ?? 0;
    return sum;
  }

  Future<int> deleteAllItems({required laundryId}) async {
    var dbClient = await db;

    int result = await dbClient!
        .delete('items', where: 'laundryId=?', whereArgs: [laundryId]);

    return result;
  }
}
