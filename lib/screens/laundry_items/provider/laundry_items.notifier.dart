import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/app_services/api_services.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/screens/laundry_items/view/blankets_category.dart';

final _blanketAndLinenFakeApiProvider =
    Provider<ApiServices>((ref) => ApiServices());

class LaundryItemsNotifier extends StateNotifier<List<ItemModel>> {
  LaundryItemsNotifier({required this.ref}) : super([]);
  final Ref ref;

  Future fetchLaundryItemSubCategories({required itemId}) async {
    await ref
        .read(_blanketAndLinenFakeApiProvider)
        .getLaundryItemSubCategories(itemId: itemId)
        .then((value) {
      state = value;
      ref.read(isLoadingProductsProvider.notifier).state = false;
    }).onError((error, stackTrace) {
      ref.read(isLoadingProductsProvider.notifier).state = true;
    });
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

  Future<List<ItemModel>> getAllLaundryItemCategory(
      {required int serviceId, required int categoryId}) async {
    print("service Id ${serviceId.toString()}");
    print("category Id ${categoryId.toString()}");

    await Future.delayed(const Duration(seconds: 0));

    List<ItemModel> items = [
      ItemModel(
          id: 1,
          image: 'assets/blankets_and_linen/Bed Cover.png',
          name: 'Bed Cover',
          serviceId: 2,
          categoryId: 1),

      ItemModel(
          id: 2,
          image: 'assets/blankets_and_linen/Bed Spread.png',
          name: 'Bed Spread',
          serviceId: 2,
          categoryId: 1),

      ItemModel(
          id: 3,
          image: 'assets/blankets_and_linen/Blanket.png',
          name: 'Blanket',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 4,
          image: 'assets/blankets_and_linen/Pillow Case.png',
          name: 'Pillow Case',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 5,
          image: 'assets/blankets_and_linen/Pillow.png',
          name: 'Pillow',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 6,
          image: 'assets/blankets_and_linen/Sheet.png',
          name: 'Sheet',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 7,
          image: 'assets/blankets_and_linen/Sleeping Bag.png',
          name: 'Sleeping Bag',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 8,
          image: 'assets/blankets_and_linen/Sofa Cover.png',
          name: 'Sofa Cover',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 9,
          image: 'assets/blankets_and_linen/Table Cloth.png',
          name: 'Table Cloth',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 10,
          image: 'assets/blankets_and_linen/Towel.png',
          name: 'Towel',
          serviceId: 2,
          categoryId: 1),
      ItemModel(
          id: 11,
          image: 'assets/clothes/laundry/Thobe.png',
          name: 'Thobe',
          serviceId: 1,
          categoryId: 1),

// Dry Cleaning

      ItemModel(
          id: 12,
          image: 'assets/clothes/laundry/Guthra.png',
          name: 'Guthra',
          serviceId: 1,
          categoryId: 2),

      ItemModel(
          id: 26,
          image: 'assets/clothes/laundry/Doctor Uniform.png',
          name: 'Doctor Uniform',
          serviceId: 1,
          categoryId: 2),

      // pressing

      ItemModel(
          id: 25,
          image: 'assets/clothes/laundry/Security Uniform.png',
          name: 'Uniforms',
          serviceId: 1,
          categoryId: 3),

// Laundry

      ItemModel(
          id: 12,
          image: 'assets/clothes/laundry/Guthra.png',
          name: 'Guthra',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 13,
          image: 'assets/clothes/laundry/Pant.png',
          name: 'Pant',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 14,
          image: 'assets/clothes/laundry/Shirt & T-Shirt.png',
          name: 'Shirt & T-Shirt',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 15,
          image: 'assets/clothes/laundry/Cap.png',
          name: 'Cap',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 16,
          image: 'assets/clothes/laundry/Under Garments.png',
          name: 'Under Garments',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 17,
          image: 'assets/clothes/laundry/hoodie.png',
          name: 'Hoodie',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 18,
          image: 'assets/clothes/laundry/Jacket.png',
          name: 'Jacket',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 19,
          image: 'assets/clothes/laundry/Abayah.png',
          name: 'Abayah',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 20,
          image: 'assets/clothes/laundry/Blouse.png',
          name: 'Blouse',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 21,
          image: 'assets/clothes/laundry/Dress Normal.png',
          name: 'Dress Normal',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 22,
          image: 'assets/clothes/laundry/Night Gown.png',
          name: 'Night Gown',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 23,
          image: 'assets/clothes/laundry/Skirt.png',
          name: 'Skirt',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 24,
          image: 'assets/clothes/laundry/School Uniform.png',
          name: 'School Uniform',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 25,
          image: 'assets/clothes/laundry/Security Uniform.png',
          name: 'Uniforms',
          serviceId: 1,
          categoryId: 1),
      ItemModel(
          id: 26,
          image: 'assets/clothes/laundry/Doctor Uniform.png',
          name: 'Doctor Uniform',
          serviceId: 1,
          categoryId: 1),

      ItemModel(
          id: 27,
          image: 'assets/carpets/normal_carpet.png',
          name: 'Carpet',
          serviceId: 3,
          categoryId: 4),

      ItemModel(
          id: 28,
          image: 'assets/carpets/mats.png',
          name: 'Mat',
          serviceId: 3,
          categoryId: 4),
    ]
        .where((element) =>
            element.serviceId == serviceId && element.categoryId == categoryId)
        .toList();
    print(items.toString());
    return items;
  }
}
