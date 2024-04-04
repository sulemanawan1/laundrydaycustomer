import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHandler {
  static getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services
//Geolocator.isLocationServiceEnabled();
      Geolocator.requestPermission();
      // return Future.error('Location services are disabled.');
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
      // AppSettings.openAppSettings(type: AppSettingsType.location);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<void> goToTheCurrentLoaction(
      {required Completer<GoogleMapController> googleMapcontroller}) async {
    final GoogleMapController controller = await googleMapcontroller.future;

    double selectedLat = 0.0;
    double selectedLng = 0.0;

    Position pos = await LocationHandler.getLocationPermission();
    selectedLat = pos.latitude;
    selectedLng = pos.longitude;

    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 90,
            target: LatLng(selectedLat, selectedLng),
            tilt: 0.0,
            zoom: 16)));
  }
}
