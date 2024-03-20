import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/screens/more/help/business_partner/state/business_partner_state.dart';

enum CategoryType { laundry }

final businessPartnerProvider = StateNotifierProvider.autoDispose<
    BusinessPartnerNotifier, BusinessPartnerState>((ref) {
  return BusinessPartnerNotifier();
});

class BusinessPartnerNotifier extends StateNotifier<BusinessPartnerState> {
  BusinessPartnerNotifier()
      : super(BusinessPartnerState(
            currentStep: 1,
            items: [
              ServicesModel(
                  vat: 0.00,
                  id: 1,
                  name: 'Clothes',
                  deliveryFee: 14.00,
                  operationFee: 2.00,
                  image: 'assets/services_clothing.jpg',
                  images: []),
              ServicesModel(
                  vat: 0.00,
                  id: 2,
                  deliveryFee: 18.00,
                  operationFee: 2.00,
                  name: 'Blankets',
                  image: 'assets/services_blankets.jpg',
                  images: []),
              ServicesModel(
                  vat: 0.00,
                  id: 3,
                  deliveryFee: 11.50,
                  operationFee: 2.00,
                  name: "Carpets",
                  image: 'assets/services_carpets.jpeg',
                  images: []),
              ServicesModel(
                  vat: 0.0,
                  id: 4,
                  deliveryFee: 14.00,
                  operationFee: 2.00,
                  name: "Furniture",
                  image: 'assets/services_furniture.jpeg',
                  images: [])
            ],
            selectedItems: [],
            image: null,
            categoryType: CategoryType.laundry));

  selectCategory(CategoryType? isSelected) {
    state.categoryType = isSelected!;
  }

  addItem(ServicesModel item) {
    state.selectedItems.add(item);
    state.selectedItems = [...state.selectedItems];
  }

  removeItem(String item) {
    log(item);

    state.selectedItems.remove(item);
    state.selectedItems = [...state.selectedItems];
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      return state = state.copyWith(image: value);
    });
  }

  stepCountIncrement() {
    state.currentStep = state.currentStep! + 1;
        state = state.copyWith(currentStep: state.currentStep);

  }

  stepCountDecrement() {
    state.currentStep = state.currentStep! - 1;
    state = state.copyWith(currentStep:  state.currentStep);
  }
}
