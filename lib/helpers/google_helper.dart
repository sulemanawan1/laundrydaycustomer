import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/core/constants/api_routes.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class GoogleServices {
  final String apiKey = Api.googleKey;

  Future<Position> currentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String?> coordinateToAddress({required LatLng taget}) async {
    List<Placemark> place = await geocoding.placemarkFromCoordinates(
        taget.latitude, taget.longitude);

    if (place.isNotEmpty) {
      return "${place.first.street},${place.first.name},${place.first.thoroughfare},${place.first.subLocality},${place.first.locality},${place.first.postalCode},${place.first.country}";
    } else {
      return null;
    }
  }

  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<String?> getDistrict(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.google.com/maps/api/geocode/json?latlng=$latitude,$longitude&sensor=false&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return _parseDistrict(data);
    } else {
      throw Exception('Failed to load geocode data');
    }
  }

  String? _parseDistrict(Map<String, dynamic> data) {
    if (data['status'] == 'OK') {
      for (var result in data['results']) {
        for (var component in result['address_components']) {
          if (component['types'].contains('sublocality')) {
            return component['long_name'];
          } else if (component['types'].contains('sublocality_level_1')) {
            return component['long_name'];
          } else if (component['types']
              .contains('administrative_area_level_2')) {
            return component['long_name'];
          }
        }
      }
    }
    return null;
  }
}
