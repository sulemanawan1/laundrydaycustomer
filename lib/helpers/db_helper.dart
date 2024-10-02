import 'dart:async';
import 'dart:developer';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart'
    as itemv;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('laundryday.db');
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
    const itemTable = '''
  CREATE TABLE item (
    id INTEGER PRIMARY KEY,
    count INTEGER,
    total_price REAL,
    name TEXT,
    arabic_name TEXT,
    image TEXT,
    service_id INTEGER,
    items TEXT,
    created_at TEXT,
    updated_at TEXT,
    category_id INTEGER
  );
  ''';

    const itemVariationSizeTable = '''
  CREATE TABLE item_variation_size (
    id INTEGER PRIMARY KEY,
    item_variation_id INTEGER,
    prefix_length INTEGER,
    prefix_width INTEGER,
    postfix_length INTEGER,
    postfix_width INTEGER,
    created_at TEXT,
    updated_at TEXT
  );
  ''';

    await db.execute(itemTable);
    await db.execute(itemVariationTable);
    await db.execute(itemVariationSizeTable);
  }

  Future<int> insertItemVariation(ItemVariation itemVariation) async {
    final db = await instance.database;
    return await db.insert('item_variations', itemVariation.toJson());
  }

  Future<void> updateItemVariations(List<ItemVariation> itemVariations) async {
    final db = await database;
    Batch batch = db.batch();
    for (var itemVariation in itemVariations) {
      batch.update(
        'item_variations',
        itemVariation.toJson(),
        where: 'id = ?',
        whereArgs: [itemVariation.id],
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> insertItemVariations(List<ItemVariation> itemVariations) async {
    final db = await database;
    Batch batch = db.batch();

    for (var itemVariation in itemVariations) {
      batch.insert('item_variations', itemVariation.toJson());
    }
    await batch.commit(noResult: true);
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

  Future<List<ItemVariation>> itemVariationsFromDB(
      int serviceTimingId, int itemId) async {
    final db = await database;

    final result = await db.query(
      'item_variations',
      where: 'service_timing_id = ? AND item_id = ?',
      whereArgs: [serviceTimingId, itemId],
    );

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

  Future<int> deleteItemVariationTable() async {
    final db = await instance.database;

    int res = await db.delete('item_variations');

    return res;
  }

  // Item Summary

  Future<int> insertItem(Item item) async {
    final db = await instance.database;
    return await db.insert('item', item.toJson());
  }

  Future<int> updateItem(Item item) async {
    final db = await instance.database;

    return await db.update(
      'item',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<List<Item>> getAllItems() async {
    final db = await instance.database;

    final result = await db.query('item');

    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<int> insertOrUpdateItemVariationSize(
      ItemVariationSizeModel itemVariationSize) async {
    final db = await instance.database;

    // Insert or replace the record if it already exists
    return await db.insert(
      ItemVariationSize.tableName,
      itemVariationSize.itemVariationSize!.toJson(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // This will insert or update
    );
  }

  Future<itemv.ItemVariationSize?> getItemVariationSize(
      int itemVariationId) async {
    final db = await instance.database;

    final maps = await db.query(
      ItemVariationSize.tableName,
      columns: ItemVariationSize.values,
      where: 'item_variation_id = ?',
      whereArgs: [itemVariationId],
    );

    if (maps.isNotEmpty) {
      log(maps.first.toString());
      return itemv.ItemVariationSize.fromJson(maps.first);
    } else {
      return null;
    }
  }
}

class ItemVariationSize {
  static const String tableName = 'item_variation_size';
  static const String columnId = 'id';
  static const String columnItemVariationId = 'item_variation_id';
  static const String columnPrefixLength = 'prefix_length';
  static const String columnPrefixWidth = 'prefix_width';
  static const String columnPostfixLength = 'postfix_length';
  static const String columnPostfixWidth = 'postfix_width';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';

  static const List<String> values = [
    columnId,
    columnItemVariationId,
    columnPrefixLength,
    columnPrefixWidth,
    columnPostfixLength,
    columnPostfixWidth,
    columnCreatedAt,
    columnUpdatedAt
  ];
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
}
