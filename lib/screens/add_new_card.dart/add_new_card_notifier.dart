import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/add_new_card.dart/add_new_card_states.dart';

class AddNewCardNotifier extends StateNotifier<AddNewCardStates> {
  AddNewCardNotifier() : super(AddNewCardStates(isValidate: false));

  isCardValidate({required bool isValidate}) {
    state = state.copyWith(isValidate: isValidate);
  }
}
