import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:laundryday/models/blankets_model.dart';

class SelectedItemsNotifier extends StateNotifier<List<LaundryItemModel>> {
  SelectedItemsNotifier({required this.ref}) : super([]);

  final Ref ref;

  checkAndUpdate(
      {required id, required LaundryItemModel blankets, required categoryId}) {
    log(id.toString());
    log(blankets.toString());

    LaundryItemModel bb = blankets;

    bb.categoryId = categoryId;

    LaundryItemModel b = state.firstWhere(
      (element) => element.id == id,
      orElse: () => LaundryItemModel(),
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
    LaundryItemModel blanketsModel =
        state.firstWhere((element) => element.id == id);

    if (blanketsModel.quantity! <= 0) {
      blanketsModel.quantity;
    } else {
      blanketsModel.quantity = blanketsModel.quantity! - 1;
    }
    state = [...state];
  }

  addQuantity({required id}) {
    LaundryItemModel blanketsModel =
        state.firstWhere((element) => element.id == id);

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

  List<LaundryItemModel>? li;
  CategoryList({
    this.categoryid,
    this.li,
  });
  
}
