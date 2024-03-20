import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/more/help/business_partner/state/business_partner_state.dart';

enum CategoryType { laundry }

final businessPartnerProvider =
    StateNotifierProvider<BusinessPartnerNotifier, BusinessPartnerState>((ref) {
  return BusinessPartnerNotifier();
});

class BusinessPartnerNotifier extends StateNotifier<BusinessPartnerState> {
  BusinessPartnerNotifier()
      : super(BusinessPartnerState(
            items: ['Furniture', 'Clothing', 'Blankets', 'Carpets'],
            selectedItems: [],
            categoryType: CategoryType.laundry));

  selectCategory(CategoryType? isSelected) {
    state.categoryType = isSelected!;
  }

  addItem(String item) {
    log(item);

    state.selectedItems.add(item);
    state.selectedItems = [...state.selectedItems];
  }

  removeItem(String item) {
    log(item);

    state.selectedItems.remove(item);
    state.selectedItems = [...state.selectedItems];
  }
}
