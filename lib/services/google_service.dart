import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:laundryday/screens/laundries/model/google_distance_matrix_model.dart';
import 'package:location/location.dart';

class GoogleServices {
  final String apiKey = Api.googleKey;
  final String googleBaseUrl = Api.googleBaseUrl;

  Future<String?> coordinateToAddress({required LatLng latLng}) async {
    List<geocoding.Placemark> place = await geocoding.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);

    if (place.isNotEmpty) {
      return "${place.first.street},${place.first.name},${place.first.thoroughfare},${place.first.subLocality},${place.first.locality},${place.first.postalCode},${place.first.country}";
    } else {
      return null;
    }
  }

  Future<http.Response> fetchNearbyLaundries({required double lat,required double lng,required double radius}) async {
    final url = Uri.parse(
      'https://${Api.googleBaseUrl}/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=laundry&key=${Api.googleKey}&language=ar',
    );
    return await http.get(url);
  }

  Future<LocationData?> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location.getLocation();
  }

  Future<AddressModel?> getAddress(double latitude, double longitude) async {
    final url =
        'https://${googleBaseUrl}/maps/api/geocode/json?latlng=$latitude,$longitude&sensor=false&key=$apiKey&language=en';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);

      final json = jsonDecode(response.body);
      if (json['status'] == 'OK' && json['results'].isNotEmpty) {
        return AddressModel.fromJson(json);
      } else {
        print('No address found');
        return null;
      }
    } else {
      print('Failed to fetch address');
      return null;
    }
  }

  Future<DistanceMatrixResponse?> fetchDistanceMatrix({
    required double laundryLat,
    required double laundryLng,
    required double userLat,
    required double userLng,
  }) async {
    final url = Uri.parse(
      'https://${Api.googleBaseUrl}/maps/api/distancematrix/json?origins=$userLat,$userLng&destinations=$laundryLat,$laundryLng&key=${Api.googleKey}&language=ar',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final element = data['rows'][0]['elements'][0];
      final destinationAddresses = data['destination_addresses'][0];
      final originAddresses = data['origin_addresses'][0];

      return DistanceMatrixResponse(
          originAddresses: originAddresses,
          destination_addresses: destinationAddresses,
          durationText: element['duration']['text'],
          distanceText: element['distance']['text'],
          distanceInMeter:
              Utils.metertoKilometer(element['distance']['value']));
    }

    return null;
  }
}
