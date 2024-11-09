import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_notifier.dart';
import 'package:laundryday/widgets/my_app_bar.dart';

class SubscriptionLaundry extends ConsumerStatefulWidget {
  final String districtName;

  SubscriptionLaundry({super.key, required this.districtName});

  @override
  ConsumerState<SubscriptionLaundry> createState() =>
      _SubscriptionLaundryState();
}

class _SubscriptionLaundryState extends ConsumerState<SubscriptionLaundry> {
  @override
  void initState() {
    super.initState();
  }

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    LatLng? initialLatLng =
        ref.watch(subscriptionLaundryProvider).initialLatLng;
    final markers = ref.watch(subscriptionLaundryProvider).markers;
    return Scaffold(
      appBar: MyAppBar(
        title: 'Subscription Laundry',
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLatLng == null ? LatLng(0, 0) : initialLatLng,
          zoom: 12,
        ),
        markers: initialLatLng == null ? {} : markers!,
        onMapCreated: (controller) {
          mapController = controller;

          if (initialLatLng != null) {
            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(initialLatLng.latitude, initialLatLng.longitude),
              ),
            );
          }
        },
      ),
    );
  }
}
