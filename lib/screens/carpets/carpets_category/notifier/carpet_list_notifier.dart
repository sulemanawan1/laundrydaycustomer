import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/carpet.dart';

final carpetsListProvider =
    StateNotifierProvider.autoDispose<CarpetsListNotifier, List<Carpet>?>(
        (ref) => CarpetsListNotifier());

class CarpetsListNotifier extends StateNotifier<List<Carpet>?> {
  CarpetsListNotifier() : super([]);
}
