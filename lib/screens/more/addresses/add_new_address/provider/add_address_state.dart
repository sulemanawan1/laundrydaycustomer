import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressState {
  String? imagePath;
  String? address;
  bool      isLoading ;

  LatLng coordinates;
  CameraPosition selectedCameraPos;
  CameraPosition initialCameraPos;
  GoogleMapController? googleMapController;
  GoogleMapController? mapController;
  AddAddressState({
   required this.isLoading,
    this.googleMapController,
    required this.coordinates,
    required this.initialCameraPos,
    required this.selectedCameraPos,
    required this.imagePath,
    this.mapController,
    required this.address,
  });

  AddAddressState copyWith(
      {
          bool?      isLoading ,

      bool? locationServiceEnabled,
      LatLng? coordinates,
      GoogleMapController? googleMapController,
      String? imagePath,
      String? address,
      CameraPosition? selectedCameraPos,
      CameraPosition? initialCameraPos,

     }) {
    return AddAddressState(
      isLoading: isLoading??this.isLoading,
      googleMapController: googleMapController??this.googleMapController,
      initialCameraPos: initialCameraPos??this.initialCameraPos,
      coordinates: coordinates ?? this.coordinates,
      selectedCameraPos: selectedCameraPos ?? this.selectedCameraPos,
       address: address ?? this.address,
        imagePath: imagePath ?? this.imagePath);
  }
}
