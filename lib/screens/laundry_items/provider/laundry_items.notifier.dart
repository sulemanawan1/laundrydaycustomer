import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/service/laundry_item_service.dart';

final laundryItemProver =
    StateNotifierProvider.autoDispose<LaundryItemsNotifier, LaundryItemStates>(
        (ref) {
  return LaundryItemsNotifier();
});

class LaundryItemsNotifier extends StateNotifier<LaundryItemStates> {
  LaundryItemsNotifier()
      : super(LaundryItemStates(
            selectedItem: null,
            total: 0.0,
            count: 0,
            selecteditemVariationList: [],
            itemVariationList: [],
            itemVariationStates: ItemVariationIntitialState(),
            selectedCategory: null,
            categoryItemsStates: CategoryItemsIntitialState(),
            nearestLaundryStates: NearestLaundryIntitialState())) {}

  Future nearestLaundries(
      {required int serviceId,
      required WidgetRef ref,
      required double userLat,
      required double userLng,
      required BuildContext context}) async {
    try {
      state =
          state.copyWith(nearestLaundryStates: NearestLaundryLoadingState());

      var data = await LaundryItemService.nearestBranch(
        serviceId: serviceId,
        radius: 3.5,
        userLat: userLat,
        userLng: userLng,
      );

      if (data is NearestLaundryModel) {
        state = state.copyWith(
            nearestLaundryStates:
                NearestLaundryLoadedState(laundryModel: data));
      }
    } catch (e) {
      state = state.copyWith(
          nearestLaundryStates:
              NearestLaundryErrorState(errorMessage: e.toString()));
    }
  }

  Future categoriesWithItems({required int serviceId}) async {
    try {
      state = state.copyWith(categoryItemsStates: CategoryItemsLoadingState());

      var data =
          await LaundryItemService.categoriesWithItems(serviceId: serviceId);

      if (data is CategoryItemModel) {
        state = state.copyWith(
            categoryItemsStates:
                CategoryItemsLoadedState(categoryItemModel: data),
            selectedCategory: data.data!.first);
      } else {
        state = state.copyWith(
            categoryItemsStates:
                CategoryItemsErrorState(errorMessage: data.toString()));
      }
    } catch (e) {
      state = state.copyWith(
          categoryItemsStates:
              CategoryItemsErrorState(errorMessage: e.toString()));
    }
  }

  void itemVariations(
      {required int itemId, required int serviceTimingId}) async {
    try {
      state = state.copyWith(itemVariationStates: ItemVariationLoadingState());

      var data = await LaundryItemService.itemVariations(
          serviceTimingId: serviceTimingId, itemId: itemId);

      if (data is ItemVariationModel) {
        state = state.copyWith(
          itemVariationStates: ItemVariationLoadedState(
            dataSource: 'api',
            itemVariationModel: data,
          ),
        );
        state = state.copyWith(itemVariationList: data.itemVariations);
      } else {
        state = state.copyWith(
            itemVariationStates:
                ItemVariationErrorState(errorMessage: data.toString()));
      }
    } catch (e) {
      state = state.copyWith(
          itemVariationStates:
              ItemVariationErrorState(errorMessage: e.toString()));
    }
  }

  void itemVariationsFromDB(
      {required int itemId, required int serviceTimingId}) async {
    try {
      state = state.copyWith(itemVariationStates: ItemVariationLoadingState());

      var dbData = await DatabaseHelper.instance
          .itemVariationsFromDB(serviceTimingId, itemId);

      if (dbData.isNotEmpty) {
        state = state.copyWith(
          itemVariationStates: ItemVariationLoadedState(
            dataSource: 'local',
            itemVariationModel: ItemVariationModel(
                itemVariations: dbData, message: 'Success', success: true),
          ),
        );
        state = state.copyWith(itemVariationList: dbData);
      } else {
        var data = await LaundryItemService.itemVariations(
            serviceTimingId: serviceTimingId, itemId: itemId);

        if (data is ItemVariationModel) {
          state = state.copyWith(
            itemVariationStates: ItemVariationLoadedState(
              itemVariationModel: data,
              dataSource: 'api',
            ),
          );
          state = state.copyWith(itemVariationList: data.itemVariations);
        } else {
          state = state.copyWith(
              itemVariationStates:
                  ItemVariationErrorState(errorMessage: data.toString()));
        }
      }
    } catch (e) {
      state = state.copyWith(
          itemVariationStates:
              ItemVariationErrorState(errorMessage: e.toString()));
    }
  }

  changeIndex({required Item catregory}) {
    state = state.copyWith(selectedCategory: catregory);
  }

  quantityIncrement({required id}) {
    ItemVariation itemVariation =
        state.itemVariationList.firstWhere((item) => item.id == id);

    if (itemVariation.quantity! <= 9) {
      itemVariation.quantity = itemVariation.quantity! + 1;
    }

    state = state.copyWith(itemVariationList: state.itemVariationList);
  }

  quanitiyDecrement({required id}) {
    ItemVariation itemVariation =
        state.itemVariationList.firstWhere((item) => item.id == id);

    if (itemVariation.quantity! > 0) {
      itemVariation.quantity = itemVariation.quantity! - 1;
    }

    state = state.copyWith(itemVariationList: state.itemVariationList);
  }

  setItemVariationLi({required List<ItemVariation> item}) {
    state.itemVariationList = item;
  }

  totalItemPrice({required Item selectedItem}) {
    double value = state.itemVariationList.fold(0.0, (res, val) {
      return (res + (val.quantity! * val.price!));
    });

    selectedItem.total_price = value;

    state = state.copyWith(selectedItem: selectedItem);
  }

  totalItemCount({required Item selectedItem}) {
    int value = state.itemVariationList.fold(0, (res, val) {
      return res + (val.quantity!);
    });

    selectedItem.count = value;

    state = state.copyWith(selectedItem: selectedItem);
  }

 

  Future getTotal() async {
    List<Item> item = await DatabaseHelper.instance.getAllItems();

    double total = item.fold(0.0, (res, val) {
      return res + val.total_price!;
    });

    state = state.copyWith(total: total);
  }

  Future getCount() async {
    List<Item> item = await DatabaseHelper.instance.getAllItems();

    int count = item.fold(0, (res, val) {
      return res + val.count!;
    });
    state = state.copyWith(count: count);
  }
}
