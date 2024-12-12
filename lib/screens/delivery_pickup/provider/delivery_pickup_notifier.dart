import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/constants/api_routes.dart';
import 'package:laundryday/constants/colors.dart';
import 'package:laundryday/helpers/order_helper.dart';
import 'package:laundryday/models/google_distance_matrix_model.dart';
import 'package:laundryday/screens/delivery_pickup/provider/delivery_pickup_states.dart';
import 'package:laundryday/services/image_picker_service.dart';
import 'package:http/http.dart' as http;

class DistanceDataModel {
  double? branchLat;
  double? branchLng;
  double? userLat;
  double? userLng;
  DistanceDataModel({
     this.branchLat,
     this.branchLng,
     this.userLat,
     this.userLng,
  });
}

class DistanceApiRepo {
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
    log(response.body);

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
          distanceInMeter: element['distance']['value']);
    }

    return null;
  }
}

final distanceApiRepo = Provider((ref) => DistanceApiRepo());

final distanceProvider =
    FutureProvider.family<DistanceMatrixResponse?, DistanceDataModel?>(
        (ref, distanceDataModel) {
  if (distanceDataModel != null) {
    return ref.read(distanceApiRepo).fetchDistanceMatrix(
        laundryLat: distanceDataModel.branchLat!,
        laundryLng: distanceDataModel.branchLng!,
        userLat: distanceDataModel.userLat!,
        userLng: distanceDataModel.userLng!);
  }
  return null;
});

class DeliveryPickupNotifier extends StateNotifier<DeliveryPickupStates> {
  DeliveryPickupNotifier() : super(DeliveryPickupStates());

  pickImage(
      {required ImageSource imageSource,
      required BuildContext context,
      required WidgetRef ref}) {
    ImagePickerService.pickImage(imageSource: imageSource).then((value) {
      log(value.toString());
      if (value != null) {
        ImageCropper().cropImage(
          sourcePath: value.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                activeControlsWidgetColor: ColorManager.primaryColor,
                toolbarTitle: 'Cropper',
                toolbarColor: ColorManager.primaryColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        ).then((value) {
          if (value != null) {
            state = state.copyWith(image: state.image = XFile(value.path));
          }
        }).onError((error, stackTrace) {
          log(error.toString());

          log(stackTrace.toString());
        });
      }
    });
  }

  goToOrderReview({
    required BuildContext context,
  }) {
    if (state.image == null) {
      Fluttertoast.showToast(msg: 'Please select Receipt.');
    } else {
      context.pushNamed(RouteNames.orderReview, extra: {
        'order_type': OrderScreenType.delivery_pickup,
      });
    }
  }
}
