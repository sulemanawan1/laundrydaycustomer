import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/services/image_picker_service.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/model/add_address_model.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/provider/add_address_state.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/service/add_address_service.dart';
import 'package:laundryday/core/utils.dart';
import 'package:location/location.dart';

final addAddressNotifier =
    StateNotifierProvider.autoDispose<AddAddressNotifier, AddAddressState>(
        (ref) => AddAddressNotifier());

class AddAddressNotifier extends StateNotifier<AddAddressState> {
  late GoogleMapController mapController;

  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  AddAddressNotifier()
      : super(AddAddressState(
          isLoading: true,
          coordinates: LatLng(0, 0),
          selectedCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          initialCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          address: null,
          imagePath: null,
        )) {
    intitilzeAddress();
  }

  Future<CameraPosition?> getCurrentCameraPosition() async {
    LocationData? pos = await GoogleServices().getLocation();
    if (pos != null) {
      log(pos.latitude.toString());
      log(pos.longitude.toString());

      final newCameraPosition = CameraPosition(
        target: LatLng(pos.latitude!, pos.longitude!),
        zoom: 16,
      );
      return newCameraPosition;
    }
    return null;
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(imagePath: value!.path));
  }

  getCameraPosition({required CameraPosition selectedCameraPos}) {
    state = state.copyWith(selectedCameraPos: selectedCameraPos);
  }

  Future coordinateToAddress({required LatLng taget}) async {
    String? address = await GoogleServices().coordinateToAddress(taget: taget);
    log(address.toString());
    state = state.copyWith(address: address);
  }

  void addAddress(
      {required int customerId,
      required WidgetRef ref,
      String? file,
      required String district,
      required String googleAddress,
      required String addressName,
      required String addressDetail,
      required double lat,
      required double lng,
      required BuildContext context}) async {
    var data = await AddAddressService.addAddress(
        district: district,
        customerId: customerId,
        file: file,
        addressName: addressName,
        addressDetail: addressDetail,
        lat: lat,
        lng: lng,
        googleAddress: googleAddress);

    log("Data $data");

    if (data is AddAddressModel) {
      Utils.showToast(msg: data.message);

      ref.invalidate(addressesProvider);
      context.pop();
    } else {
      Utils.showToast(msg: data);
      throw Exception(data);
    }
  }

  intitilzeAddress() async {
    LocationData? position = await GoogleServices().getLocation();

    if (position != null) {
      final newCameraPosition = CameraPosition(
        target: LatLng(position.latitude!, position.longitude!),
        zoom: 16,
      );
      state =
          state.copyWith(isLoading: false, initialCameraPos: newCameraPosition);

      await coordinateToAddress(
          taget: LatLng(position.latitude!, position.longitude!));



    }
  }
}
