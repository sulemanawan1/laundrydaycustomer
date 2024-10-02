import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:laundryday/helpers/db_helper.dart';
import 'package:laundryday/screens/laundries/view/laundries.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart'
    as itemsize;

import 'package:laundryday/screens/laundry_items/provider/laundry_item_states.dart';
import 'package:laundryday/screens/laundry_items/service/laundry_item_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/laundry_items/model/category_item_model.dart'
    as categorymodel;

final laundryItemProver =
    StateNotifierProvider.autoDispose<LaundryItemsNotifier, LaundryItemStates>(
        (ref) {
  return LaundryItemsNotifier();
});

// Categories

final categoryApi = Provider((ref) {
  return CategoryService();
});

final categoriesProvider =
    FutureProvider.autoDispose<Either<String, CategoryItemModel>>((ref) async {
  final selectedService = ref.read(serviceProvider).selectedService;
  return await ref
      .read(categoryApi)
      .categoriesWithItems(serviceId: selectedService!.id!);
});

// Item Variation Size

final itemVariationSizeApi = Provider((ref) {
  return ItemVariationService();
});

final itemvariationSizeProvider = FutureProvider.family
    .autoDispose<Either<String, ItemVariationSizeModel>, int>(
        (ref, itemVariationId) async {
  return await ref
      .read(itemVariationSizeApi)
      .getItemVariationSize(itemVariationId: itemVariationId);
});

class LaundryItemsNotifier extends StateNotifier<LaundryItemStates> {
  LaundryItemsNotifier()
      : super(LaundryItemStates(
          itemVariationSize: null,
          selectedItem: null,
          total: 0.0,
          count: 0,
          selecteditemVariationList: [],
          itemVariationList: [],
          itemVariationStates: ItemVariationIntitialState(),
          selectedCategory: null,
        )) {}

  // Future categoriesWithItems({required int serviceId}) async {
  //   try {

  //     var data =
  //         await LaundryItemService.categoriesWithItems(serviceId: serviceId);

  //     if (data is CategoryItemModel) {
  //       // state = state.copyWith(
  //       //     categoryItemsStates:
  //       //         CategoryItemsLoadedState(categoryItemModel: data),
  //       //     selectedCategory: data.data!.first);
  //     } else {

  //     }
  //   } catch (e) {

  //   }
  // }

  setItemVariationSize(
      {required itemsize.ItemVariationSize itemVariationSize}) {
    state = state.copyWith(itemVariationSize: itemVariationSize);
  }

  setPrefixLength({required int prefixLength}) {
    state.itemVariationSize!.prefixLength = prefixLength;

    state = state.copyWith(itemVariationSize: state.itemVariationSize);
  }

  setPrefixWidth({required int prefixWidth}) {
    state.itemVariationSize!.prefixWidth = prefixWidth;

    state = state.copyWith(itemVariationSize: state.itemVariationSize);
  }

  setPostFixLength({required int postFixLength}) {
    state.itemVariationSize!.postfixLength = postFixLength;

    state = state.copyWith(itemVariationSize: state.itemVariationSize);
  }

  setPostFixWidth({required int postFixWidth}) {
    state.itemVariationSize!.postfixWidth = postFixWidth;

    state = state.copyWith(itemVariationSize: state.itemVariationSize);
  }

  selectCategory({required categorymodel.Item item}) {
    state = state.copyWith(selectedCategory: item);
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

  quantityIncrement({required id, required Datum? selectedService}) {
    ItemVariation itemVariation =
        state.itemVariationList.firstWhere((item) => item.id == id);

    if (selectedService!.serviceName!.toLowerCase() ==
        ServiceTypes.carpets.name) {
      if (itemVariation.quantity! < 1) {
        itemVariation.quantity = itemVariation.quantity! + 1;
      }
    } else if (selectedService.serviceName!.toLowerCase() ==
        ServiceTypes.clothes.name) {
      if (itemVariation.quantity! < 5) {
        itemVariation.quantity = itemVariation.quantity! + 1;
      }
    } else if (selectedService.serviceName!.toLowerCase() ==
        ServiceTypes.blankets.name) {
      if (itemVariation.quantity! < 2) {
        itemVariation.quantity = itemVariation.quantity! + 1;
      } else if (selectedService.serviceName!.toLowerCase() ==
          ServiceTypes.furniture.name) {
        if (itemVariation.quantity! < 10) {
          itemVariation.quantity = itemVariation.quantity! + 1;
        }
      }
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
