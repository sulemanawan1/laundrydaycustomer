import 'dart:convert';
import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/models/google_laundry_model.dart';
import 'package:laundryday/models/user_subscription_model.dart';
import 'package:laundryday/constants/assets_manager.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/screens/offers/provider/offers_notifier.dart';
import 'package:laundryday/screens/subscription/provider/subscription_notifier.dart';
import 'package:laundryday/screens/subscription_laundry/provider/subscription_laundry_states.dart';
import 'package:laundryday/services/google_service.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

final subscriptionLaundryProvider = StateNotifierProvider.autoDispose<
    SubscriptionLaundryNotifier,
    SubscriptionLaundryStates>((ref) => SubscriptionLaundryNotifier());

class SubscriptionLaundryNotifier
    extends StateNotifier<SubscriptionLaundryStates> {
  GoogleMapController? mapController;
  BitmapDescriptor? customMarker;
  String? addreess;

  SubscriptionLaundryNotifier()
      : super(SubscriptionLaundryStates(
          laundries: [],
          initialLatLng: null,
          markers: {},
        )) {
    initilizeMarkerfromAssets();
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

  Future<Either<String, List<GoogleLaundryModel>>> nearestLaundries(
      {required LatLng latLng}) async {
    try {
      List<GoogleLaundryModel> laundries = [];
      JsonCodec codec = new JsonCodec();

      http.Response response = await GoogleServices.fetchNearbyLaundries(
          lat: latLng.latitude, lng: latLng.longitude, radius: 3000);

      log(response.body);

      if (response.statusCode == 200) {
        final data = codec.decode(
          response.body,
        );

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
      log(s.toString());

      return left('Failed to load laundries');
    }
  }

  initilizeMarkerfromAssets() async {
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

  currentLocation() async {
    BotToast.showLoading();
    LocationData? currentLocation = await GoogleServices.getLocation();

    if (currentLocation != null && mapController != null) {
      Either<String, List<GoogleLaundryModel>> laundries =
          await nearestLaundries(
              latLng: LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      ));

      laundries.fold((l) {
        log(l);

        BotToast.closeAllLoading();
      }, (r) async {
        addreess = await GoogleServices.coordinateToAddress(
            latLng: LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        ));

        state.markers.clear();

        for (int i = 0; i < r.length; i++) {
          state.markers.add(Marker(
              onTap: () {},
              icon: state.markerIcon!,
              markerId: MarkerId('${r[i].lat},${r[i].lng}'),
              position: LatLng(r[i].lat, r[i].lng)));

          state.laundries.add(r[i]);
        }

        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: 13.0,
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
      });

      BotToast.closeAllLoading();
    }
  }

  updateBranch(
      {required Map data,
      required BuildContext context,
      required WidgetRef ref}) async {
    BotToast.showLoading();

    Either<String, UserSubscriptionModel> apiData =
        await ref.read(userSubscriptionRepoProvider).updateBranch(data: data);

    apiData.fold((l) {
      log(l);

      BotToast.closeAllLoading();
      BotToast.showNotification(
          title: (title) => Text(
                l,
                style: getRegularStyle(color: ColorManager.whiteColor),
              ),
          backgroundColor: ColorManager.redColor);
    }, (r) {
      BotToast.showNotification(
          duration: Duration(seconds: 3),
          title: (title) => Text(
                r.message.toString(),
                style: getRegularStyle(color: ColorManager.whiteColor),
              ),
          backgroundColor: ColorManager.redColor);

      context.pop();

      ref.invalidate(fetchUserProvider);
      ref.invalidate(activeUserSubscriptionProvider);

      Future.delayed(Duration(seconds: 2), () {
        BotToast.closeAllLoading();
      });
    });
  }
}
