import 'dart:async';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/helpers/distance_calculator_helper.dart';
import 'package:laundryday/models/google_laundry_model.dart';
import 'package:laundryday/models/laundry_by_area.model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_states.dart';
import 'package:laundryday/screens/laundries/service/laundries_services.dart';
import 'package:laundryday/models/service_timings_model.dart'  as servicetimingmodel;
import 'package:laundryday/models/laundry_by_area.model.dart'as laundrybyareamodel;
import 'package:laundryday/screens/laundries/service/service_timing_service.dart';
import 'package:laundryday/screens/services/provider/addresses_notifier.dart';
import 'package:laundryday/screens/services/provider/services_notifier.dart';
import 'package:laundryday/screens/services/model/services_model.dart' as servicemodel;
import 'package:laundryday/services/google_service.dart';

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
    try {
      List<GoogleLaundryModel> laundries = [];

      final placesResponse = await GoogleServices.fetchNearbyLaundries(
          lat: userLat, lng: userLng, radius: 3000);

      String? originAddresses = await GoogleServices.coordinateToAddress(
          latLng: LatLng(userLat, userLng));

      if (placesResponse.statusCode == 200) {
        final data = jsonDecode(placesResponse.body);
        List<dynamic> laundryList = data['results'];

        for (int i = 0; i < laundryList.length; i++) {
          var laundry = laundryList[i];

          double distanceInKm = DistanceCalculatorHelper.calculateDistance(
              userLat,
              userLng,
              laundry['geometry']['location']['lat'],
              laundry['geometry']['location']['lng']);

          laundries.add(
            GoogleLaundryModel(
              vicinity: laundry['vicinity'] ?? null,
              distanceInKm: distanceInKm,
              destinationAddresses: laundry['vicinity'],
              originAddresses: originAddresses,
              name: laundry['name'],
              rating: laundry['rating'],
              openingHours: laundry['opening_hours']?['open_now'] ?? false,
              lat: laundry['geometry']['location']['lat'],
              lng: laundry['geometry']['location']['lng'],
              duration: null,
              distance: null,
            ),
          );
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
    try {
      List<GoogleLaundryModel> laundries = [];

      String? originAddresses = await GoogleServices.coordinateToAddress(
          latLng: LatLng(userLat, userLng));

      final placesResponse = await GoogleServices.fetchNearbyLaundries(
          lat: userLat, lng: userLng, radius: 3000);

      if (placesResponse.statusCode == 200) {
        final data = jsonDecode(placesResponse.body);

        List<dynamic> laundryList = data['results'];

        for (int i = 0; i < laundryList.length; i++) {
          var laundry = laundryList[i];

          double distanceInKm = DistanceCalculatorHelper.calculateDistance(
              userLat,
              userLng,
              laundry['geometry']['location']['lat'],
              laundry['geometry']['location']['lng']);

          laundries.add(
            GoogleLaundryModel(
              vicinity: laundry['vicinity'] ?? null,
              distanceInKm: distanceInKm,
              destinationAddresses: laundry['vicinity'],
              originAddresses: originAddresses,
              name: laundry['name'],
              rating: laundry['rating'],
              openingHours: laundry['opening_hours']?['open_now'] ?? false,
              lat: laundry['geometry']['location']['lat'],
              lng: laundry['geometry']['location']['lng'],
              duration: null,
              distance: null,
            ),
          );
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

  selectedLaundry({required GoogleLaundryModel selectedLaundry}) {
    print(selectedLaundry.name.toString());

    state = state.copyWith(selectedLaundry: selectedLaundry);
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



