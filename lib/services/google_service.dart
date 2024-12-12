import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/models/address_model.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class GoogleServices {
  GoogleServices._();
  static final String apiKey = Api.googleKey;
  static final String googleBaseUrl = Api.googleBaseUrl;

  static Future<String?> coordinateToAddress({required LatLng latLng}) async {
    List<geocoding.Placemark> place = await geocoding.placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);

    if (place.isNotEmpty) {
      return "${place.first.street},${place.first.name},${place.first.thoroughfare},${place.first.subLocality},${place.first.locality},${place.first.postalCode},${place.first.country}";
    } else {
      return null;
    }
  }

  static Future<http.Response> fetchNearbyLaundries(
      {required double lat,
      required double lng,
      required double radius}) async {
    final url = Uri.parse(
      'https://${Api.googleBaseUrl}/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=laundry&key=${Api.googleKey}&language=ar',
    );

    http.Response response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    return response;
  }

  static Future<LocationData?> getLocation() async {
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

  static Future<AddressModel?> getAddress(
      double latitude, double longitude) async {
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

  
}
