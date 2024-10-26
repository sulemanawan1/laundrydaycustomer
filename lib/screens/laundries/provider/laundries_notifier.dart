import 'dart:async';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/laundries/model/google_laundry_model.dart';
import 'package:laundryday/screens/laundries/model/google_distance_matrix_model.dart';
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_states.dart';
import 'package:laundryday/screens/laundries/service/laundries_services.dart';
import 'package:laundryday/resources/api_routes.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart'
    as servicetimingmodel;
import 'dart:math';
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart'
    as laundrybyareamodel;
import 'package:laundryday/screens/laundries/service/service_timing_service.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/model/services_model.dart'
    as servicemodel;

final laundriesServicesProvider = Provider((ref) {
  return LaundriesServices();
});

final branchbyAreaProvider =
    FutureProvider.autoDispose<Either<String, LaundryByAreaModel>>((ref) async {
  final selectedAddress = ref.read(selectedAddressProvider);
  final servicemodel.Datum? selectedService =
      ref.read(serviceProvider).selectedService;
  return await ref.read(laundriesServicesProvider).branchByArea(
      serviceId: selectedService?.id ?? 0,
      userLat: selectedAddress!.lat ?? 0.0,
      userLng: selectedAddress.lng ?? 0.0);
});

final serviceTimingApi = Provider((ref) {
  return ServiceTimingService();
});

final serviceTimingProvider = FutureProvider.autoDispose<
    Either<String, servicetimingmodel.ServiceTimingModel>>((ref) async {
  final selectedService = ref.read(serviceProvider).selectedService;

  return await ref
      .read(serviceTimingApi)
      .serviceTimings(serviceId: selectedService!.id!);
});

final laundriessProvider =
    StateNotifierProvider<LaundriesNotifier, LaundriesStates>(
        (ref) => LaundriesNotifier());

final aljabrAndAlrahdenLaundryProvider =
    FutureProvider.autoDispose<Either<String, List<GoogleLaundryModel>>>(
        (ref) async {
  final selectedAddress = ref.read(selectedAddressProvider);
  return await ref
      .read(laundriessProvider.notifier)
      .fetchAljabrAndAlrahdenLaundries(
          userLat: selectedAddress!.lat!, userLng: selectedAddress.lng!);
});

final pickupLaundriesProvider =
    FutureProvider.autoDispose<Either<String, List<GoogleLaundryModel>>>(
        (ref) async {
  final selectedAddress = ref.read(selectedAddressProvider);
  return await ref.read(laundriessProvider.notifier).deliveryPickupLaundries(
      userLat: selectedAddress!.lat!, userLng: selectedAddress.lng!);
});

class LaundriesNotifier extends StateNotifier<LaundriesStates> {
  LaundriesNotifier()
      : super(LaundriesStates(
          selectedLaundryByArea: Datum(),
        ));

  DeliveryAgentsAvailibilityService _deliveryAgentsAvailibilityService =
      DeliveryAgentsAvailibilityService();

  selectedServiceTiming({required servicetimingmodel.Datum serviceTiming}) {
    state = state.copyWith(serviceTiming: serviceTiming);
  }

  selectedLaundryByArea(
      {required laundrybyareamodel.Datum selectedLaundryByArea}) {
    print(selectedLaundryByArea.name);

    state = state.copyWith(selectedLaundryByArea: selectedLaundryByArea);
  }

  Future<Either<String, List<GoogleLaundryModel>>> deliveryPickupLaundries({
    required double userLat,
    required double userLng,
  }) async {
    print(userLat);
    print(userLng);

    try {
      List<GoogleLaundryModel> laundries = [];

      final placesResponse = await _fetchNearbyLaundries(userLat, userLng);

      if (placesResponse.statusCode == 200) {
        final data = jsonDecode(placesResponse.body);
        List<dynamic> laundryList = data['results'];

        // Prepare distance matrix requests
        List<Future<DistanceMatrixResponse?>> distanceMatrixFutures =
            laundryList.map((laundry) async {
          final lat = laundry['geometry']['location']['lat'];
          final lng = laundry['geometry']['location']['lng'];

          return await _fetchDistanceMatrix(
            laundryLat: lat,
            laundryLng: lng,
            userLat: userLat,
            userLng: userLng,
          );
        }).toList();

        // Execute all distance matrix requests in parallel
        List<DistanceMatrixResponse?> distanceMatrixResults =
            await Future.wait(distanceMatrixFutures);

        // Process the results
        for (int i = 0; i < laundryList.length; i++) {
          var laundry = laundryList[i];
          var distanceMatrixResult = distanceMatrixResults[i];

          if (distanceMatrixResult != null) {
            laundries.add(
              GoogleLaundryModel(
                distanceInKm: distanceMatrixResult.distanceInMeter,
                destinationAddresses:
                    distanceMatrixResult.destination_addresses,
                originAddresses: distanceMatrixResult.originAddresses,
                name: laundry['name'],
                rating: laundry['rating'],
                openingHours: laundry['opening_hours'] != null
                    ? laundry['opening_hours']['open_now']
                    : false,
                lat: laundry['geometry']['location']['lat'],
                lng: laundry['geometry']['location']['lng'],
                duration: distanceMatrixResult.durationText,
                distance: distanceMatrixResult.distanceText,
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
          return !excludeWords.any(
                  (word) => item.name.toString().toLowerCase().contains(word))
              //     &&
              // item.distanceInKm <= 3.0
              ;
        }).toList();

        return right(filteredLaundry);
      } else {
        throw Exception('Failed to load laundries');
      }
    } catch (e) {
      print(e);
      return left('Failed to load laundries');
    }
  }

  Future<Either<String, List<GoogleLaundryModel>>>
      fetchAljabrAndAlrahdenLaundries({
    required double userLat,
    required double userLng,
  }) async {
    print(userLat);
    print(userLng);

    try {
      List<GoogleLaundryModel> laundries = [];

      final placesResponse = await _fetchNearbyLaundries(userLat, userLng);

      if (placesResponse.statusCode == 200) {
        final data = jsonDecode(placesResponse.body);
        List<dynamic> laundryList = data['results'];

        // Prepare distance matrix requests
        List<Future<DistanceMatrixResponse?>> distanceMatrixFutures =
            laundryList.map((laundry) async {
          final lat = laundry['geometry']['location']['lat'];
          final lng = laundry['geometry']['location']['lng'];

          return await _fetchDistanceMatrix(
            laundryLat: lat,
            laundryLng: lng,
            userLat: userLat,
            userLng: userLng,
          );
        }).toList();

        // Execute all distance matrix requests in parallel
        List<DistanceMatrixResponse?> distanceMatrixResults =
            await Future.wait(distanceMatrixFutures);

        // Process the results
        for (int i = 0; i < laundryList.length; i++) {
          var laundry = laundryList[i];
          var distanceMatrixResult = distanceMatrixResults[i];

          if (distanceMatrixResult != null) {
            laundries.add(
              GoogleLaundryModel(
                distanceInKm: distanceMatrixResult.distanceInMeter,
                destinationAddresses:
                    distanceMatrixResult.destination_addresses,
                originAddresses: distanceMatrixResult.originAddresses,
                name: laundry['name'],
                rating: laundry['rating'],
                openingHours: laundry['opening_hours'] != null
                    ? laundry['opening_hours']['open_now']
                    : false,
                lat: laundry['geometry']['location']['lat'],
                lng: laundry['geometry']['location']['lng'],
                duration: distanceMatrixResult.durationText,
                distance: distanceMatrixResult.distanceText,
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
          return !excludeWords.any((word) =>
                      item.name.toString().toLowerCase().contains(word)) &&
                  item.name.toString().toLowerCase().trim().contains('الجبر') ||
              (item.name.toString().toLowerCase().trim().contains('الرهدن'));
        }).toList();

        return right(filteredLaundry);
      } else {
        throw Exception('Failed to load laundries');
      }
    } catch (e) {
      print(e);
      return left('Failed to load laundries');
    }
  }

  Future<http.Response> _fetchNearbyLaundries(double lat, double lng) async {
    final url = Uri.parse(
      'https://${Api.googleBaseUrl}/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=800&type=laundry&key=${Api.googleKey}&language=ar',
    );
    return await http.get(url);
  }

  Future<DistanceMatrixResponse?> _fetchDistanceMatrix({
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

  selectedLaundry({required GoogleLaundryModel selectedLaundry}) {
    print(selectedLaundry.name.toString());

    state = state.copyWith(selectedLaundry: selectedLaundry);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in km
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<bool> nearByAgents(
      {required double latitude,
      required double longitude,
      required WidgetRef ref,
      required BuildContext context}) async {
    bool isAgentAvailable = false;

    try {
      Either<String, Map> apiData = await _deliveryAgentsAvailibilityService
          .nearByAgents(latitude: latitude, longitude: longitude);

      apiData.fold((l) {
        if (l == 'Not-Found') {
          BotToast.showNotification(
            leading: (cancelFunc) => Icon(Icons.info),
            backgroundColor: Colors.orange,
            title: (title) {
              print(l);
              return Text("Sorry There is no Delivery Agent in your Area");
            },
          );
        } else {
          BotToast.showNotification(
            leading: (cancelFunc) => Icon(Icons.info),
            backgroundColor: Colors.orange,
            title: (title) {
              return Text(l);
            },
          );
        }
        isAgentAvailable = false;
      }, (r) {
        isAgentAvailable = true;
      });
      return isAgentAvailable;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}
