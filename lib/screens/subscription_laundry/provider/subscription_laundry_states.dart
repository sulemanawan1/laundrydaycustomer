import 'package:google_maps_flutter/google_maps_flutter.dart';

class SubscriptionLaundryStates {
  LatLng? initialLatLng;
 Set<Marker>? markers;
  SubscriptionLaundryStates({
    this.initialLatLng,
    this.markers
  });

  SubscriptionLaundryStates copyWith({
    LatLng? initialLatLng,
   Set<Marker>?  markers,
  }) {
    return SubscriptionLaundryStates(
      markers: markers ??this.markers,
      initialLatLng: initialLatLng ?? this.initialLatLng,
    );
  }
}
