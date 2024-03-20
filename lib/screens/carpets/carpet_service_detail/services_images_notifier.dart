import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesImagesNotifier =
    StateNotifierProvider.autoDispose<ServicesImagesNotifier, List<String?>>(
  (ref) => ServicesImagesNotifier(),
);

class ServicesImagesNotifier extends StateNotifier<List<String?>> {
  ServicesImagesNotifier() : super([]);

  addImages({required List<String?> images}) {
    state = images;
  }
}
