
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/models/languages.dart';

final lanugaeProvider =
    StateNotifierProvider.autoDispose<SettingNotifier, List<Languages>>(
        (ref) => SettingNotifier());

class SettingNotifier extends StateNotifier<List<Languages>> {
  SettingNotifier()
      : super(
          [
            Languages(name: 'English', isSelected: false),
            Languages(name: "عربي", isSelected: false,
          )
          ],
        );

  
  }

