import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalProvider =
    StateNotifierProvider.autoDispose<TotalNotifier, double>(
        (ref) => TotalNotifier());

class TotalNotifier extends StateNotifier<double> {
  TotalNotifier() : super(0.0);
}
