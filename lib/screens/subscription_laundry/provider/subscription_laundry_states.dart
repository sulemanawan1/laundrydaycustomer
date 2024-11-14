import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/models/district_model.dart' as districts;
import 'package:laundryday/screens/laundries/model/google_laundry_model.dart';

class SubscriptionLaundryStates {
  BitmapDescriptor? markerIcon;
  BitmapDescriptor? selectedMarkerIcon;

  districts.Datum? district;
  LatLng? initialLatLng;
  Set<Marker> markers;
  Set<Polygon> polygons;
  List<LatLng> boundries;
  String? address;
  List<GoogleLaundryModel> laundries;
  GoogleLaundryModel? selectedBranch;
  SubscriptionLaundryStates(
      { this.markerIcon,
      this.selectedMarkerIcon,
        this.initialLatLng,
      required this.markers,
      this.selectedBranch,
      required this.polygons,
      required this.boundries,
      required this.laundries,
      this.address,
      this.district});

  SubscriptionLaundryStates copyWith(
      { BitmapDescriptor? markerIcon,
  BitmapDescriptor? selectedMarkerIcon,
        String? address,
      GoogleLaundryModel? selectedBranch,
      districts.Datum? district,
      List<GoogleLaundryModel>? laundries,
      LatLng? initialLatLng,
      List<LatLng>? boundries,
      Set<Marker>? markers,
      Set<Polygon>? polygons}) {
    return SubscriptionLaundryStates(
      selectedMarkerIcon: selectedMarkerIcon??this.selectedMarkerIcon,
      markerIcon: markerIcon??this.markerIcon,
      selectedBranch: selectedBranch ?? selectedBranch,
      laundries: laundries ?? this.laundries,
      boundries: boundries ?? this.boundries,
      polygons: polygons ?? this.polygons,
      district: district ?? this.district,
      address: address ?? this.address,
      markers: markers ?? this.markers,
      initialLatLng: initialLatLng ?? this.initialLatLng,
    );
  }
}
