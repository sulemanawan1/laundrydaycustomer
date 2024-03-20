import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/carpet_category_laundry.dart';

final laundryListProvider =
    StateNotifierProvider<LaundryListNotifier, List<CarpetCategoryLaundry>?>(
        (ref) => LaundryListNotifier());

class LaundryListNotifier extends StateNotifier<List<CarpetCategoryLaundry>?> {
  LaundryListNotifier() : super([]);
}
