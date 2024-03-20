import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/models/carpet.dart';

final itemListProvider =
    StateNotifierProvider.autoDispose<ItemListNotifier, List<Carpet?>>(
        (ref) => ItemListNotifier());

class ItemListNotifier extends StateNotifier<List<Carpet?>> {
  final DBHelper dbHelper = DBHelper();
  ItemListNotifier() : super([]);

  deleteItem({required laundryId}) {
    dbHelper
        .deleteAllItems(laundryId: laundryId)
        .then((value) => state.clear());

    state = [...state];
  }
}
