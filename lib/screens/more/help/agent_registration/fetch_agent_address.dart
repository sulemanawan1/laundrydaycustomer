// ignore_for_file: unused_field

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/auth/signup/signup.dart';
import 'package:laundryday/utils/colors.dart';
import 'package:laundryday/utils/constants/sized_box.dart';
import 'package:laundryday/utils/constants/value_manager.dart';
import 'package:laundryday/widgets/my_app_bar.dart';
import 'package:laundryday/widgets/my_button.dart';

class FetchAgentAddress extends StatefulWidget {
  const FetchAgentAddress({super.key});

  @override
  State<FetchAgentAddress> createState() => _FetchAgentAddressState();
}

class _FetchAgentAddressState extends State<FetchAgentAddress> {
  double _selectedLat = 0.0;
  double _selectedLng = 0.0;
  String? _city;

  String? _address;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _goToTheCurrentLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Agent Address'),
      body: Consumer(builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(alignment: Alignment.center, children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(_selectedLat, _selectedLng),
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  compassEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _selectedLat = cameraPosition.target.latitude;
                    _selectedLng = cameraPosition.target.longitude;
                  },
                  onCameraIdle: () async {
                    try {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _selectedLat, _selectedLng);

                      if (placemarks.isNotEmpty) {
                        Placemark placemark = placemarks[0];
                        _address =
                            "${placemark.street},${placemark.subLocality},${placemark.thoroughfare} ";
                        _city = "${placemark.locality}";

                        log("Street: ${placemark.street},City: ${placemark.locality} ");
                      } else {
                        _address = 'No address found for the coordinates';
                        _city = 'No address found for the coordinates';
                      }
                    } catch (e) {
                      _address = 'Error: $e';
                      _city = 'Error: $e';
                    }
                  },
                ),
                Icon(
                  Icons.location_on,
                  color: ColorManager.primaryColor,
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: _goToTheCurrentLoaction,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.whiteColor),
                        child: const Center(child: Icon(Icons.my_location)),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.ph,
                    HeadingMedium(
                      title: 'Address',
                      color: ColorManager.primaryColor,
                    ),
                    10.ph,
                    Text(
                      _address ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    )
                  ]),
            ),
            40.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: MyButton(
                title: 'Pick Address',
                onPressed: () {
                  // GoRouter.of(context)
                  //     .go('/agent_registration?address=$address&city=$city');
                },
              ),
            ),
            40.ph
          ],
        );
      }),
    );
  }

  Future<void> _goToTheCurrentLoaction() async {
    final GoogleMapController controller = await _controller.future;

    // Position pos = await LocationHandler.getLocationPermission();
    // _selectedLat = pos.latitude;
    // _selectedLng = pos.longitude;

    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 90,
            target: LatLng(_selectedLat, _selectedLng),
            tilt: 0.0,
            zoom: 16)));
  }
}
