import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/model/add_address_model.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/provider/add_address_state.dart';
import 'package:laundryday/screens/more/addresses/add_new_address/service/add_address_service.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/screens/more/addresses/my_addresses/provider/my_addresses_notifier.dart';
import 'package:laundryday/utils/utils.dart';
import 'package:location/location.dart';

final addAddressNotifier =
    StateNotifierProvider.autoDispose<AddAddressNotifier, AddAddressState>(
        (ref) => AddAddressNotifier());

class AddAddressNotifier extends StateNotifier<AddAddressState> {
  late GoogleMapController mapController;
  Location location = Location();

  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  PermissionStatus _permissionGranted = PermissionStatus.denied;
  AddAddressNotifier()
      : super(AddAddressState(
          coordinates: LatLng(0, 0),
          selectedCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          initialCameraPos: CameraPosition(target: LatLng(0, 0), zoom: 14),
          locationServiceEnabled: false,
          address: null,
          imagePath: null,
        )) {
    // determinePosition();

    checkLocationPermission();
    getCurrent();
  }

  getCurrent() async {
    Position position = await determinePosition();

    final newCameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
    state.initialCameraPos = newCameraPosition;
    state.googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(state.initialCameraPos),
    );
    state = state.copyWith(initialCameraPos: state.initialCameraPos);

    coordinateToAddress(taget: newCameraPosition.target);
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(imagePath: value!.path));
  }

  userSelectedAddress({required String address}) {
    state = state.copyWith(address: address);
  }

  Future<void> checkLocationPermission() async {
    state.locationServiceEnabled = await location.serviceEnabled();
    if (!state.locationServiceEnabled) {
      state.locationServiceEnabled = await location.requestService();
      if (!state.locationServiceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  updatetoCurrent({
    required CameraPosition selectedCameraPos,
  }) async {
    // await controller.animateCamera(CameraUpdate.newCameraPosition(camera));
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

  void addAddress(
      {required int customerId,
      required WidgetRef ref,
      String? file,
      required String googleAddress,
      required String addressName,
      required String addressDetail,
      required double lat,
      required double lng,
      required BuildContext context}) async {
    var data = await AddAddressService.addAddress(
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

      ref.invalidate(myAddresesProvider);
      context.pop();
    } else {
      Utils.showToast(msg: data);
      throw Exception(data);
    }
  }
}
