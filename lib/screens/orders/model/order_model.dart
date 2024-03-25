import 'package:faker/faker.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/user_model.dart';

class OrderModel {
  final LaundryModel laundryModel;
  final UserModel userModel;
  final Address address;
  final ItemModel laundryItemModel;

  OrderModel(
      {required this.laundryModel,
      required this.userModel,
      required this.address,
      required this.laundryItemModel});
}
