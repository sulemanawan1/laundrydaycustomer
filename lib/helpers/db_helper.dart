import 'dart:async';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('item_variations.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const itemVariationTable = '''
    CREATE TABLE item_variations (
      id INTEGER PRIMARY KEY,
      name TEXT,
      arabic_name TEXT,
      price REAL,
      quantity INTEGER,
      category_id INTEGER,
      item_id INTEGER,
      service_timing_id INTEGER,
      hasSize INTEGER,
      created_at TEXT,
      updated_at TEXT
    );
    ''';

    await db.execute(itemVariationTable);
  }

  Future<int> insertItemVariation(ItemVariation itemVariation) async {
    final db = await instance.database;
    return await db.insert('item_variations', itemVariation.toJson());
  }

  Future<ItemVariation?> getItemVariation(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'item_variations',
      columns: ItemVariationl.values,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemVariation.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ItemVariation>> getAllItemVariations() async {
    final db = await instance.database;

    final result = await db.query('item_variations');

    return result.map((json) => ItemVariation.fromJson(json)).toList();
  }

  Future<int> updateItemVariation(ItemVariation itemVariation) async {
    final db = await instance.database;

    return await db.update(
      'item_variations',
      itemVariation.toJson(),
      where: 'id = ?',
      whereArgs: [itemVariation.id],
    );
  }

  Future<int> deleteItemVariation(int id) async {
    final db = await instance.database;

    return await db.delete(
      'item_variations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}


class ItemVariationl {
  static const String tableName = 'item_variations';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnArabicName = 'arabic_name';
  static const String columnPrice = 'price';
  static const String columnQuantity = 'quantity';
  static const String columnCategoryId = 'category_id';
  static const String columnItemId = 'item_id';
  static const String columnServiceTimingId = 'service_timing_id';
  static const String columnHasSize = 'hasSize';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  static const List<String> values = [
    columnId,
    columnName,
    columnArabicName,
    columnPrice,
    columnQuantity,
    columnCategoryId,
    columnItemId,
    columnServiceTimingId,
    columnHasSize,
    columnCreatedAt,
    columnUpdatedAt
  ];

  // ... rest of the class remains unchanged
}
