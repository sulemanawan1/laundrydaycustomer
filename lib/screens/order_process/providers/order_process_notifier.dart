import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/order_status.dart';
import 'package:laundryday/screens/order_process/providers/order_process_states.dart';
import 'package:location/location.dart';

class OrderProcessNotifier extends StateNotifier<OrderProcessStates> {
  OrderProcessNotifier()
      : super(OrderProcessStates(
            currentLocation: null,
            orderStatusList: [
              OrderStatus(
                isActive: true,
                id: 1,
                orderId: 1,
                status: 0,
                description: 'Accepted\nOrder',
                createdAt: DateTime.now(),
              ),
              OrderStatus(
                  description: 'Approach\nYou',
                  isActive: false,
                  id: 2,
                  orderId: 1,
                  status: 1,
                  createdAt: DateTime.now().add(const Duration(minutes: 5))),
              OrderStatus(
                description: 'Invoice\nCreated',
                isActive: false,
                id: 3,
                orderId: 1,
                status: 2,
                createdAt: DateTime.now().add(const Duration(minutes: 10)),
              ),
              OrderStatus(
                description: 'Order\nPickup',
                id: 4,
                isActive: false,
                orderId: 1,
                status: 3,
                createdAt: DateTime.now().add(const Duration(minutes: 20)),
              ),
              OrderStatus(
                description: 'Approach\nYou',
                isActive: false,
                id: 5,
                orderId: 1,
                status: 4,
                createdAt: DateTime.now().add(const Duration(minutes: 30)),
              ),
              OrderStatus(
                description: 'Order\nDelivered',
                isActive: false,
                id: 6,
                orderId: 1,
                status: 5,
                createdAt: DateTime.now().add(const Duration(minutes: 40)),
              )
            ],
            orderStatus: 0));

  updateStatus({required int status}) {
    state = state.copyWith(orderStatus: status);
  }

  updateIsActive({required id}) {
    OrderStatus orderStatus =
        state.orderStatusList.firstWhere((element) => element.id == id);
    orderStatus.isActive = !orderStatus.isActive;

    state = state.copyWith(orderStatusList: state.orderStatusList);
  }

  void getCurrentLocation() async {
    final Completer<GoogleMapController> googleMapcontroller =
        Completer<GoogleMapController>();

    Location location = Location();
    location.enableBackgroundMode(enable: true);

    location.getLocation().then(
      (location) {
        log("latitude${location.latitude.toString()}");
        log("longitude${location.longitude.toString()}");

        state = state.copyWith(currentLocation: location);
      },
    );
    GoogleMapController googleMapController = await googleMapcontroller.future;

    location.onLocationChanged.listen(
      (newLoc) {
        state = state.copyWith(currentLocation: newLoc);

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      },
    );
  }
}
