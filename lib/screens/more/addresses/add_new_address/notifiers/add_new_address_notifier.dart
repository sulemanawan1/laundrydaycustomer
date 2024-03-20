import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/add_address_state.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';

class AddAddressNotifier extends StateNotifier<AddAddressState> {
  AddAddressNotifier() : super(AddAddressState(address: null, imagePath: null));

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(imagePath: value!.path));
  }

  userSelectedAddress({required String address}) {
    state = state.copyWith(address: address);
  }
}
