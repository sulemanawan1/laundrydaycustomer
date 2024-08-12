import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/core/image_picker_handler.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/model/update_address_model.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/provider/update_address_state.dart';
import 'package:laundryday/screens/more/addresses/update_addresses/service/update_address_service.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/model/my_addresses_model.dart'
    as myaddressesmodel;

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
    ImagePickerHandler.pickImage(imageSource: imageSource)
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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
      required String addressName,
      required String addressDetail,
      required double lat,
      required double lng,
      required BuildContext context}) async {
    var data = await UpdateAddressService.updateAddress(
        addressId: addressId,
        customerId: customerId,
        file: file,
        addressName: addressName,
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
    addressNameController.text = address.addressName!;
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
