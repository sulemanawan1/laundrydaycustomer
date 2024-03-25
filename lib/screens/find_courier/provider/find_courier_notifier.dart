import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/screens/find_courier/provider/find_courier_states.dart';

class FindCourierNotifier extends StateNotifier<FindCourierState> {
  FindCourierNotifier()
      : super(
            FindCourierState(selectedLat: 0.0, selectedLng: 0.0, markers: []));

  addMarkers({required List<Marker> markers}) {
   state= state.copyWith(markers: markers);
  }
}
