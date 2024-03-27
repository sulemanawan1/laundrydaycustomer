import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:laundryday/models/item_model.dart';

class SelectedItemsNotifier extends StateNotifier<List<ItemModel>> {
  SelectedItemsNotifier({required this.ref}) : super([]);

  final Ref ref;

  checkAndUpdate(
      {required id, required ItemModel blankets, required categoryId}) {
    log(id.toString());
    log(blankets.toString());

    ItemModel bb = blankets;

    bb.categoryId = categoryId;

    ItemModel b = state.firstWhere(
      (element) => element.id == id,
      orElse: () => ItemModel(),
    );

    if (b.id == null) {
      state.add(bb);
    } else if (b.id == id) {
      log("Yes");
      log("Total blanekt length ${state.length}");
    } else {
      log("Total blanekt length ${state.length}");
    }
  }

  removeQuantity({required id}) {
    ItemModel blanketsModel = state.firstWhere((element) => element.id == id);

    if (blanketsModel.quantity! <= 0) {
      blanketsModel.quantity;
    } else {
      blanketsModel.quantity = blanketsModel.quantity! - 1;
    }
    state = [...state];
  }

  addQuantity({required id}) {
    ItemModel blanketsModel = state.firstWhere((element) => element.id == id);

    if (blanketsModel.quantity! >= 10) {
      blanketsModel.quantity = 10;
    } else {
      blanketsModel.quantity = blanketsModel.quantity! + 1;
    }
    state = [...state];
  }

  deleteQuantity({required id}) {
    state.removeWhere((element) => element.id == id);

    state = [...state];
  }
}

class CategoryList {
  String? categoryid;

  List<ItemModel>? li;
  CategoryList({
    this.categoryid,
    this.li,
  });
}
