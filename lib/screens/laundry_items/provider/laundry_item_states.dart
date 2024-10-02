import 'package:laundryday/screens/laundry_items/model/category_item_model.dart'
    as categorymodel;
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_size_model.dart';

class LaundryItemStates {
  double total;
  int count;
  ItemVariationStates itemVariationStates;
  List<ItemVariation> itemVariationList;
  List<ItemVariation> selecteditemVariationList;
  // CategoryItemsStates categoryItemsStates;
  ItemVariationSize? itemVariationSize;

  categorymodel.Item? selectedCategory;
  categorymodel.Item? selectedItem;

  LaundryItemStates({

    required this.itemVariationSize,
    required this.count,
    required this.selectedItem,
    required this.total,
    required this.selecteditemVariationList,
    required this.itemVariationList,
    required this.itemVariationStates,
    required this.selectedCategory,
  });

  LaundryItemStates copyWith(
      {
          ItemVariationSize? itemVariationSize,

        categorymodel.Item? selectedItem,
      List<ItemVariation>? itemVariationList,
      List<ItemVariation>? selecteditemVariationList,
      ItemVariationStates? itemVariationStates,
      categorymodel.Item? selectedCategory,
      double? total,
      int? count,
      int? categoryIndex}) {
    return LaundryItemStates(
      itemVariationSize: itemVariationSize??this.itemVariationSize,
      count: count ?? this.count,
      total: total ?? this.total,
      selectedItem: selectedItem ?? this.selectedItem,
      selecteditemVariationList:
          selecteditemVariationList ?? this.selecteditemVariationList,
      itemVariationList: itemVariationList ?? this.itemVariationList,
      itemVariationStates: itemVariationStates ?? this.itemVariationStates,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

abstract class NearestLaundryStates {}

abstract class CategoryItemsStates {}

class CategoryItemsIntitialState extends CategoryItemsStates {}

class CategoryItemsLoadingState extends CategoryItemsStates {}

class CategoryItemsLoadedState extends CategoryItemsStates {
  categorymodel.CategoryItemModel categoryItemModel;
  CategoryItemsLoadedState({required this.categoryItemModel});
}

class CategoryItemsErrorState extends CategoryItemsStates {
  String errorMessage;
  CategoryItemsErrorState({required this.errorMessage});
}

abstract class ItemVariationStates {}

class ItemVariationIntitialState extends ItemVariationStates {}

class ItemVariationLoadingState extends ItemVariationStates {}

class ItemVariationLoadedState extends ItemVariationStates {
  ItemVariationModel itemVariationModel;
  String dataSource;
  ItemVariationLoadedState(
      {required this.itemVariationModel, required this.dataSource});
}

class ItemVariationErrorState extends ItemVariationStates {
  String errorMessage;
  ItemVariationErrorState({required this.errorMessage});
}
