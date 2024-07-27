import 'package:laundryday/screens/laundry_items/model/category_item_model.dart';
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';

class LaundryItemStates {
  ItemVariationStates itemVariationStates;
  NearestLaundryStates nearestLaundryStates;

  List<ItemVariation> itemVariationList;
  List<ItemVariation> selecteditemVariationList;

  CategoryItemsStates categoryItemsStates;
  Datum? selectedCategory;
  LaundryItemStates({
    required this.selecteditemVariationList,
    required this.itemVariationList,
    required this.itemVariationStates,
    required this.selectedCategory,
    required this.categoryItemsStates,
    required this.nearestLaundryStates,
  });

  LaundryItemStates copyWith(
      {List<ItemVariation>? itemVariationList,
        List<ItemVariation>? selecteditemVariationList,

      ItemVariationStates? itemVariationStates,
      CategoryItemsStates? categoryItemsStates,
      NearestLaundryStates? nearestLaundryStates,
      Datum? selectedCategory,
      int? categoryIndex}) {
    return LaundryItemStates(
      selecteditemVariationList: selecteditemVariationList??this.selecteditemVariationList,
      itemVariationList: itemVariationList ?? this.itemVariationList,
      itemVariationStates: itemVariationStates ?? this.itemVariationStates,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryItemsStates: categoryItemsStates ?? this.categoryItemsStates,
      nearestLaundryStates: nearestLaundryStates ?? this.nearestLaundryStates,
    );
  }
}

abstract class NearestLaundryStates {}

class NearestLaundryIntitialState extends NearestLaundryStates {}

class NearestLaundryLoadingState extends NearestLaundryStates {}

class NearestLaundryLoadedState extends NearestLaundryStates {
  NearestLaundryModel laundryModel;
  NearestLaundryLoadedState({required this.laundryModel});
}

class NearestLaundryErrorState extends NearestLaundryStates {
  String errorMessage;
  NearestLaundryErrorState({required this.errorMessage});
}

abstract class CategoryItemsStates {}

class CategoryItemsIntitialState extends CategoryItemsStates {}

class CategoryItemsLoadingState extends CategoryItemsStates {}

class CategoryItemsLoadedState extends CategoryItemsStates {
  CategoryItemModel categoryItemModel;
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
  ItemVariationLoadedState({required this.itemVariationModel});
}

class ItemVariationErrorState extends ItemVariationStates {
  String errorMessage;
  ItemVariationErrorState({required this.errorMessage});
}
