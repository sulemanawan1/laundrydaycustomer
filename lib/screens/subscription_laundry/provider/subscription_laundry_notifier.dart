import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_states.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:location/location.dart';

final subscriptionLaundryProvider = StateNotifierProvider<
    SubscriptionLaundryNotifier,
    SubscriptionLaundryStates>((ref) => SubscriptionLaundryNotifier());

class SubscriptionLaundryNotifier
    extends StateNotifier<SubscriptionLaundryStates> {
  SubscriptionLaundryNotifier()
      : super(SubscriptionLaundryStates(initialLatLng: null)) {
    currecntLocation();
  }

  currecntLocation() async {
    LocationData? currentLocation = await GoogleServices().getLocation();

    if (currentLocation != null) {
      log('Latitude ${currentLocation.latitude}');
      log('Longitude ${currentLocation.longitude}');
      // initializationMarkers(
      //     position:
      //         LatLng(currentLocation.latitude!, currentLocation.longitude!));
      state = state.copyWith(
          initialLatLng:
              LatLng(currentLocation.latitude!, currentLocation.longitude!));
    }
  }

  initializationMarkers({required LatLng position}) {
    state.markers!.add(Marker(
      draggable: true,
      onDrag: (v) {},
      position: position,
      markerId: MarkerId('Current'),
    ));

    state = state.copyWith(markers: state.markers);
  }
}
