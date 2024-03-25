import 'package:laundryday/models/item_model.dart';

class DeliveryPickupRepository {
  Future<List<ItemModel>> getAllItems({required int serviceId}) async {
    await Future.delayed(const Duration(seconds: 2));

    List<ItemModel> items = [
      ItemModel(id: 1, name: "Bed Spread", quantity: 0, serviceId: 2),
      ItemModel(id: 2, name: "Blanket", quantity: 0, serviceId: 2),
      ItemModel(id: 3, name: "Pillow", quantity: 0, serviceId: 2),
      ItemModel(id: 4, name: "Sleeping Bag", quantity: 0, serviceId: 2),
      ItemModel(id: 5, name: "Pillow Case", quantity: 0, serviceId: 2),
      ItemModel(id: 6, name: "Sheet", quantity: 0, serviceId: 2),
      ItemModel(id: 7, name: "Bed Cover", quantity: 0, serviceId: 2),
      ItemModel(id: 8, name: "Sofa Cover", quantity: 0, serviceId: 2),
      ItemModel(id: 9, name: "Table Cloth", quantity: 0, serviceId: 2),
      ItemModel(id: 10, name: "Towel", quantity: 0, serviceId: 2),
      ItemModel(id: 11, name: "Guthra", quantity: 0, serviceId: 1),
      ItemModel(id: 12, name: "Thobe", quantity: 0, serviceId: 1),
      ItemModel(id: 13, name: "Pant", quantity: 0, serviceId: 1),
      ItemModel(id: 14, name: "Shirt", quantity: 0, serviceId: 1),
      ItemModel(id: 15, name: "Cap", quantity: 0, serviceId: 1),
      ItemModel(id: 16, name: "Jacket", quantity: 0, serviceId: 1),
      ItemModel(id: 17, name: "Abayah", quantity: 0, serviceId: 1),
      ItemModel(id: 18, name: "Blouse", quantity: 0, serviceId: 1),
      ItemModel(id: 19, name: "Night Gown", quantity: 0, serviceId: 1),
      ItemModel(id: 20, name: "Skirt", quantity: 0, serviceId: 1),
      ItemModel(id: 26, name: "School Uniform", quantity: 0, serviceId: 1),
      ItemModel(id: 21, name: "Vest", quantity: 0, serviceId: 1),
      ItemModel(id: 22, name: "Farwah", quantity: 0, serviceId: 1),
      ItemModel(id: 23, name: "Suit", quantity: 0, serviceId: 1),
      ItemModel(id: 24, name: "Sweater", quantity: 0, serviceId: 1),
      ItemModel(id: 25, name: "Muffler", quantity: 0, serviceId: 1),
    ].where((element) => element.serviceId == serviceId).toList();

    return items;
  }
}
