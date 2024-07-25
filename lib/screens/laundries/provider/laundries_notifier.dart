import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/screens/laundries/model/delivery_pickup_laundry_model.dart';
import 'package:laundryday/screens/laundries/model/google_distance_matrix_model.dart';
import 'package:laundryday/screens/laundries/model/laundry_by_area.model.dart';
import 'package:laundryday/screens/laundries/provider/laundries_states.dart';
import 'package:laundryday/screens/laundries/service/laundries_services.dart';
import 'package:laundryday/core/constants/api_routes.dart';
import 'package:laundryday/screens/laundries/model/services_timings_model.dart'
    as servicetimingmodel;

final laundriessProvider =
    StateNotifierProvider<LaundriesNotifier, LaundriesStates>(
        (ref) => LaundriesNotifier());

class LaundriesNotifier extends StateNotifier<LaundriesStates> {
  LaundriesNotifier()
      : super(LaundriesStates(
            deliveryPickupLaundryState: DeliveryPickupLaundryIntitialState(),
            laundryByAreaState: LaundryByAreaIntitialState())) {}

  void branchByArea({
    required int serviceId,
    required String district,
    required double userLat,
    required double userLng,
  }) async {
    print(serviceId);
    print(district);
    print(userLat);
    print(userLng);

    try {
      state = state.copyWith(laundryByAreaState: LaundryByAreaLoadingState());
      var data = await LaundriesServices.branchByArea(
          district: district,
          serviceId: serviceId,
          userLat: userLat,
          userLng: userLng);

      if (data is LaundryByAreaModel) {
        state = state.copyWith(
            laundryByAreaState:
                LaundryByAreaLoadedState(laundryByAreaModel: data));
      } else {
        state = state.copyWith(
            laundryByAreaState: LaundryByAreaErrorState(errorMessage: data));
      }
    } catch (e) {
      state = state.copyWith(
          laundryByAreaState:
              LaundryByAreaErrorState(errorMessage: e.toString()));
      throw Exception(e);
    }
  }

  selectedServiceTiming({required servicetimingmodel.Datum serviceTiming}) {
    state = state.copyWith(serviceTiming: serviceTiming);
  }

  Future<void> deliveryPickupLaundries({
    required double userLat,
    required double userLng,
  }) async {
    print(userLat);
    print(userLng);

    try {
      List<DeliveryPickupLaundryModel> laundries = [];

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
              DeliveryPickupLaundryModel(
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

        state = state.copyWith(
          deliveryPickupLaundryState: DeliveryPickupLaundryLoadedState(
            deliveryPickupLaundryModel: laundries,
          ),
        );
      } else {
        throw Exception('Failed to load laundries');
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        deliveryPickupLaundryState: DeliveryPickupLaundryErrorState(
          errorMessage: "Failed to load laundries: $e",
        ),
      );
    }
  }

  Future<http.Response> _fetchNearbyLaundries(double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=3500&type=laundry&key=${Api.googleKey}',
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
      'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$userLat,$userLng&destinations=$laundryLat,$laundryLng&key=${Api.googleKey}&language=ar',
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
