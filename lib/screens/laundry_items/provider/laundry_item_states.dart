import 'package:laundryday/screens/laundry_items/model/category_item_model.dart'
    as categorymodel;
import 'package:laundryday/screens/laundry_items/model/item_variation_model.dart';
import 'package:laundryday/screens/laundry_items/model/laundry_model.dart';

class LaundryItemStates {
  double total;
  int count;
  ItemVariationStates itemVariationStates;
  NearestLaundryStates nearestLaundryStates;

  List<ItemVariation> itemVariationList;
  List<ItemVariation> selecteditemVariationList;

  CategoryItemsStates categoryItemsStates;
  categorymodel.Item? selectedCategory;
  categorymodel.Item? selectedItem;

  LaundryItemStates({
    required this.count,
    required this.selectedItem,
    required this.total,
    required this.selecteditemVariationList,
    required this.itemVariationList,
    required this.itemVariationStates,
    required this.selectedCategory,
    required this.categoryItemsStates,
    required this.nearestLaundryStates,
  });

  LaundryItemStates copyWith(
      {categorymodel.Item? selectedItem,
      List<ItemVariation>? itemVariationList,
      List<ItemVariation>? selecteditemVariationList,
      ItemVariationStates? itemVariationStates,
      CategoryItemsStates? categoryItemsStates,
      NearestLaundryStates? nearestLaundryStates,
      categorymodel.Item? selectedCategory,
       double? total,
      int? count,
      int? categoryIndex}) {
    return LaundryItemStates(
      count: count??this.count ,
       total: total ?? this.total,

      selectedItem: selectedItem ?? this.selectedItem,
      selecteditemVariationList:
          selecteditemVariationList ?? this.selecteditemVariationList,
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
