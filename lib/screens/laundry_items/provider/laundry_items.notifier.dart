import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';
import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/service/laundry_item_service.dart';

final laundryItemProver =
    StateNotifierProvider<LaundryItemsNotifier, LaundryItemStates>((ref) {
  return LaundryItemsNotifier();
});

class LaundryItemsNotifier extends StateNotifier<LaundryItemStates> {
  LaundryItemsNotifier()
      : super(LaundryItemStates(
            itemVariationStates: ItemVariationIntitialState(),
            selectedCategory: null,
            categoryItemsStates: CategoryItemsIntitialState(),
            nearestLaundryStates: NearestLaundryIntitialState())) {}

  void nearestLaundries(
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

  void categoriesWithItems({required int serviceId}) async {
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
          itemVariationStates:
              ItemVariationLoadedState(itemVariationModel: data),
        );
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

  changeIndex({required Datum catregory}) {
    state = state.copyWith(selectedCategory: catregory);
  }


  addQuantity({required id}) {



   
  }

  removeQuantity({required id}) {
   
  }
}
