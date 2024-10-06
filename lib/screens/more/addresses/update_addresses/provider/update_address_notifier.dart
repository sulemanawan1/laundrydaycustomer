import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/services/image_picker_service.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/model/update_address_model.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/provider/update_address_state.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/service/update_address_service.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressesmodel;
import 'package:location/location.dart';

final updateAddressProvider = StateNotifierProvider.autoDispose<
    UpdateAddressNotifier,
    UpdateAddressState>((ref) => UpdateAddressNotifier());

class UpdateAddressNotifier extends StateNotifier<UpdateAddressState> {
  late GoogleMapController mapController;
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  UpdateAddressNotifier()
      : super(UpdateAddressState(
          coordinates: LatLng(0, 0),
          selectedCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          initialCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          locationServiceEnabled: false,
          address: null,
          imagePath: null,
        )) {
    // checkLocationPermission();
    // getCurrent();
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(imagePath: value!.path));
  }

  userSelectedAddress({required String address}) {
    state = state.copyWith(address: address);
  }

  updatetoCurrent({
    required CameraPosition selectedCameraPos,
  }) async {
    state = state.copyWith(selectedCameraPos: selectedCameraPos);
  }

  Future<LocationData?> getCurrentCameraPosition() async {
    LocationData? pos = await GoogleServices().getLocation();
    if (pos != null) {
      log(pos.latitude.toString());
      log(pos.longitude.toString());

      return pos;
    }
    return null;
  }

  coordinateToAddress({required LatLng taget}) {
    geocoding
        .placemarkFromCoordinates(taget.latitude, taget.longitude)
        .then((place) {
      if (place.isNotEmpty) {
        state = state.copyWith(
            address:
                "${place.first.street},${place.first.name},${place.first.thoroughfare},${place.first.subLocality},${place.first.locality},${place.first.postalCode},${place.first.country}");
      } else {
        state = state.copyWith(address: null);
      }
    });
  }

  void updateAddress(
      {required int customerId,
      required int addressId,
      required WidgetRef ref,
      String? file,
      required String googleAddress,
      required String addressDetail,
      required double lat,
      required double lng,
      required BuildContext context}) async {
    var data = await UpdateAddressService.updateAddress(
        addressId: addressId,
        userId: customerId,
        file: file,
        addressDetail: addressDetail,
        lat: lat,
        lng: lng,
        googleAddress: googleAddress);

    log("Data $data");

    if (data is UpdateAddressModel) {
      Utils.showToast(msg: data.message.toString());

      ref.invalidate(myAddresesProvider);
      context.pop();
    } else {
      Utils.showToast(msg: data.toString());
      throw Exception(data);
    }
  }

  intitilzeAddress({required myaddressesmodel.Address address}) {
    addressDetailController.text = address.addressDetail!;
    state.address = address.googleMapAddress;

    final newCameraPosition = CameraPosition(
      target: LatLng(address.lat!, address.lng!),
      zoom: 14,
    );
    state.initialCameraPos = newCameraPosition;

    coordinateToAddress(taget: newCameraPosition.target);
  }
}
