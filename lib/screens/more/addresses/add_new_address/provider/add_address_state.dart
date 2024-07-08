import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressState {
  String? imagePath;
  String? address;
  LatLng coordinates;
  CameraPosition selectedCameraPos;
  CameraPosition initialCameraPos;
  GoogleMapController? googleMapController;

  bool locationServiceEnabled;
  GoogleMapController? mapController;
  AddAddressState({
    this.googleMapController,
    required this.coordinates,
    required this.initialCameraPos,
    required this.selectedCameraPos,
    required this.imagePath,
    required this.locationServiceEnabled,
    this.mapController,
    required this.address,
  });

  AddAddressState copyWith(
      {bool? locationServiceEnabled,

      LatLng? coordinates,
      GoogleMapController? googleMapController,
      String? imagePath,
      String? address,
      CameraPosition? selectedCameraPos,
      CameraPosition? initialCameraPos,

     }) {
    return AddAddressState(
      googleMapController: googleMapController??this.googleMapController,
      initialCameraPos: initialCameraPos??this.initialCameraPos,
        coordinates: coordinates ?? this.coordinates,
        selectedCameraPos: selectedCameraPos ?? this.selectedCameraPos,
        locationServiceEnabled:
            locationServiceEnabled ?? this.locationServiceEnabled,
        address: address ?? this.address,
        imagePath: imagePath ?? this.imagePath);
  }
}
