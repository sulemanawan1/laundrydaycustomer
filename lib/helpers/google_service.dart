import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/services/resources/api_routes.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class GoogleServices {
  final String apiKey = Api.googleKey;

  Future<String?> coordinateToAddress({required LatLng taget}) async {
    List<geocoding.Placemark> place = await geocoding.placemarkFromCoordinates(
        taget.latitude, taget.longitude);

    if (place.isNotEmpty) {
      return "${place.first.street},${place.first.name},${place.first.thoroughfare},${place.first.subLocality},${place.first.locality},${place.first.postalCode},${place.first.country}";
    } else {
      return null;
    }
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
