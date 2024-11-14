import 'dart:convert';
import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/repsositories/district_repository.dart';
import 'package:laundryday/resources/assets_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/screens/laundries/model/google_laundry_model.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_states.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

final subscriptionLaundryProvider = StateNotifierProvider.autoDispose<
    SubscriptionLaundryNotifier,
    SubscriptionLaundryStates>((ref) => SubscriptionLaundryNotifier(ref: ref));

final districtRepoProvider = Provider((ref) => DistrictRepository());

class SubscriptionLaundryNotifier
    extends StateNotifier<SubscriptionLaundryStates> {
  Ref ref;
  GoogleMapController? mapController;
  BitmapDescriptor? customMarker;
  String? addreess;
  SubscriptionLaundryNotifier({required this.ref})
      : super(SubscriptionLaundryStates(
            laundries: [],
            boundries: [],
            initialLatLng: null,
            markers: {},
            polygons: {})) {
    initilizeMarkers();
    currentLocation();
  }

  selectedBranch({GoogleLaundryModel? selectedBranch}) async {
    log(state.markers.length.toString());

    state.markers.removeWhere(
        (e) => e.position == LatLng(selectedBranch!.lat, selectedBranch.lng));

    state.markers.add(Marker(
        icon: state.selectedMarkerIcon!,
        markerId: MarkerId(DateTime.now().timeZoneName.toString()),
        position: LatLng(selectedBranch!.lat, selectedBranch.lng)));

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(selectedBranch.lat, selectedBranch.lng),
          zoom: 13.0,
        ),
      ),
    );

    state =
        state.copyWith(selectedBranch: selectedBranch, markers: state.markers);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radiusOfEarthKm = 6371.0; // Radius of Earth in kilometers
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return radiusOfEarthKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  Future<Either<String, List<GoogleLaundryModel>>> nearestLaundries(
      {required LatLng latLng}) async {
    try {
      List<GoogleLaundryModel> laundries = [];
      final placesResponse = await GoogleServices().fetchNearbyLaundries(
          lat: latLng.latitude, lng: latLng.longitude, radius: 3000);

      if (placesResponse.statusCode == 200) {
        // log(placesResponse.body);
        // String fixedResponse =
        //     placesResponse.body.replaceAll('"status" : "O', '"status" : "OK"}');

        // // log(fixedResponse);
        final data = jsonDecode(placesResponse.body);

        List<dynamic> laundryList = data['results'];

        for (int i = 0; i < laundryList.length; i++) {
          var laundry = laundryList[i];

          laundries.add(
            GoogleLaundryModel(
              vicinity: laundry['vicinity'],
              name: laundry['name'],
              rating: laundry['rating'],
              openingHours: false,
              lat: laundry['geometry']['location']['lat'],
              lng: laundry['geometry']['location']['lng'],
              duration: null,
              distance: null,
              originAddresses: null,
              destinationAddresses: null,
              distanceInKm: 0.0,
            ),
          );
        }
      }

      List<String> excludeWords = [
        'سيارات',
        'سيارة',
        'car',
        'cars',
        'vechiles',
        'vechile'
      ];

      List<GoogleLaundryModel> filteredLaundry = laundries.where((item) {
        return !excludeWords
            .any((word) => item.name.toString().toLowerCase().contains(word));
      }).toList();

      return right(filteredLaundry);
    } catch (e, s) {
      log(e.toString());

      log(s.toString());

      return left('Failed to load laundries');
    }
  }

  initilizeMarkers() async {
    final BitmapDescriptor markerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(25, 25)), // Adjust size as needed
      AssetImages.selectedMarker,
    );

    final BitmapDescriptor selectedMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(25, 25)), // Adjust size as needed
      AssetImages.marker,
    );

    state = state.copyWith(
        markerIcon: markerIcon, selectedMarkerIcon: selectedMarkerIcon);
  }

//   void onAreaSelected({required districts.Datum selectedDistrict}) {
//     final selectDistrict = selectedDistrict;

//     String? boundaries = selectDistrict.boundaries;
//     var coordinates =
//         boundaries.toString().replaceAll('POLYGON((', '').replaceAll('))', '');
// // Split by comma to get each point
//     List<String> points = coordinates.split(',');

// // Convert points to LatLng
//     List<LatLng> polygonPoints = points.map((point) {
//       // Split each point by space to separate latitude and longitude
//       List<String> latLng = point.trim().split(' ');

//       double longitude = double.parse(latLng[0]);
//       double latitude = double.parse(latLng[1]);

//       return LatLng(latitude, longitude);
//     }).toList();

//     state = state.copyWith(boundries: polygonPoints);

//     state.polygons.clear();
//     state.polygons.add(
//       Polygon(
//         polygonId: PolygonId(selectDistrict.nameEn.toString()),
//         points: polygonPoints,
//         strokeColor: ColorManager.primaryColor,
//         strokeWidth: 2,
//         fillColor: ColorManager.primaryColor.withOpacity(0.3),
//       ),
//     );

//     state =
//         state.copyWith(polygons: state.polygons, district: selectedDistrict);

//     mapController!.animateCamera(CameraUpdate.newLatLngBounds(
//       getPolygonBounds(polygonPoints),
//       50,
//     ));
//   }

  // LatLngBounds getPolygonBounds(List<LatLng> points) {
  //   double? minLat, maxLat, minLng, maxLng;
  //   for (var point in points) {
  //     if (minLat == null || point.latitude < minLat) minLat = point.latitude;
  //     if (maxLat == null || point.latitude > maxLat) maxLat = point.latitude;
  //     if (minLng == null || point.longitude < minLng) minLng = point.longitude;
  //     if (maxLng == null || point.longitude > maxLng) maxLng = point.longitude;
  //   }
  //   return LatLngBounds(
  //     southwest: LatLng(minLat!, minLng!),
  //     northeast: LatLng(maxLat!, maxLng!),
  //   );
  // }

  currentLocation() async {
    LocationData? currentLocation = await GoogleServices().getLocation();

    if (currentLocation != null && mapController != null) {
      state = state.copyWith(
        initialLatLng: LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        ),
      );

      Either<String, List<GoogleLaundryModel>> laundries =
          await nearestLaundries(
              latLng: LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      ));

      laundries.fold((l) {
        log(l);
      }, (r) async {
        state.markers.clear();

        for (int i = 0; i < r.length; i++) {
          state.markers.add(Marker(
              onTap: () {},
              icon: state.markerIcon!,
              markerId: MarkerId('${r[i].lat},${r[i].lng}'),
              position: LatLng(r[i].lat, r[i].lng)));

          state.laundries.add(r[i]);
        }
      });

      addreess = await coordinateToAddress(
          latLng: LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      ));

      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                currentLocation.latitude!,
                currentLocation
                    .longitude!), // Example: San Francisco coordinates
            zoom: 13.0, // Initial zoom level
          ),
        ),
      );

      state = state.copyWith(
          laundries: state.laundries,
          initialLatLng: LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          ),
          markers: state.markers,
          address: addreess);
    }
  }

  Future<String?> coordinateToAddress({required LatLng latLng}) async {
    String? address =
        await GoogleServices().coordinateToAddress(latLng: latLng);

    return address;
  }

  // bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
  //   int intersectCount = 0;
  //   for (int j = 0; j < polygon.length - 1; j++) {
  //     if (_rayCastIntersect(point, polygon[j], polygon[j + 1])) {
  //       intersectCount++;
  //     }
  //   }
  //   return (intersectCount % 2) == 1; // Odd count means point is inside
  // }

  // bool _rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
  //   double px = point.latitude, py = point.longitude;
  //   double ax = vertA.latitude, ay = vertA.longitude;
  //   double bx = vertB.latitude, by = vertB.longitude;
  //   if ((ay > py) != (by > py) &&
  //       (px < (bx - ax) * (py - ay) / (by - ay) + ax)) {
  //     return true;
  //   }
  //   return false;
  // }
}
