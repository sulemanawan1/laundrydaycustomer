import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindCourierState {
  double selectedLat;
  double selectedLng;

  List<Marker>? markers;

  FindCourierState({required this.selectedLat, required this.selectedLng, this.markers});

  FindCourierState copyWith(
      {double selectedLat = 0.0, double selectedLng = 0.0,
        List<Marker>? markers

      
      
      }) {
    return FindCourierState(
      selectedLat: selectedLat, selectedLng: selectedLng,

      markers: markers??markers
      
      
      );
  }
}
