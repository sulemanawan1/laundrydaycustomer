import 'dart:convert';
import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/config/theme/styles_manager.dart';
import 'package:laundryday/resources/colors.dart';
import 'package:laundryday/screens/more/help/agent_registration/service/agent_registration_service.dart';
import 'package:laundryday/services/image_picker_service.dart';
import 'package:laundryday/helpers/date_helper.dart';
import 'package:laundryday/screens/add_laundry/data/repository/add_laundry_repository.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/model/delivery_agent_registartion_model.dart';
import 'package:laundryday/screens/more/help/agent_registration/provider/delivery_agent_registartion_states.dart';
import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:http/http.dart' as http;
import 'package:laundryday/config/routes/route_names.dart';
import 'package:laundryday/core/utils.dart';

final getDeliveryAgentApi = Provider((ref) {
  return AgentRegistrationService();
});

class DeliveryAgentRegistrationNotifier
    extends StateNotifier<DeliveryAgentStates> {
  countrymodel.CountryModel? countryModel;
  regionmodel.RegionModel? regionModel;
  citymodel.CityModel? cityModel;
  districtmodel.DistrictModel? districtModel;
  DeliveryAgentRegistrationNotifier()
      : super(DeliveryAgentStates(
            deliveryAgentButtonState: DeliveryAgentButtonInitialState(),
            IdentityTypes: ["National Id", "Resident Id"])) {
    countries();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController identityTypeController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController classificationController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController plateNumberDigitsController = TextEditingController();
  TextEditingController plateNumberLettersController = TextEditingController();
  final plateNumberLetterFocus = FocusNode();

  pickImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(image: value));
  }

  pickIdentityImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(identityImage: value));
  }

  pickRearImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(rearImage: value));
  }

  pickFrontImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(frontImage: value));
  }

  pickdrivingLicenceImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(drivingLicenseImage: value));
  }

  pickRegistrationeImage({required ImageSource imageSource}) {
    ImagePickerService.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(registrationImage: value));
  }

  void countries() async {
    var data = await AddLaundryRepository.countries();

    if (kDebugMode) {
      print("Data $data");
    }

    if (data is countrymodel.CountryModel) {
      countryModel = data;
      state = state.copyWith(
        countryModel: data,
      );
    } else {
      state = state.copyWith(countryModel: null);
    }
  }

  void regions() async {
    var data = await AddLaundryRepository.regions();

    if (kDebugMode) {
      print("Data $data");
    }

    if (data is regionmodel.RegionModel) {
      regionModel = data;
      state = state.copyWith(
        regionModel: data,
      );
    } else {
      state = state.copyWith(regionModel: null);
    }
  }

  void cities({required int regionId}) async {
    var data = await AddLaundryRepository.cities(regionId: regionId);
    if (kDebugMode) {
      print("Data $data");
    }

    if (data is citymodel.CityModel) {
      cityModel = data;
      state = state.copyWith(
        cityModel: data,
      );
    } else {
      state = state.copyWith(cityModel: null);
    }
  }

  void districts({required int cityId}) async {
    var data = await AddLaundryRepository.districts(cityId: cityId);

    if (data is districtmodel.DistrictModel) {
      districtModel = data;
      state = state.copyWith(
        districtModel: data,
      );
    } else {
      state = state.copyWith(districtModel: null);
    }
  }

  selectedCountry({required countrymodel.Datum selectedCoutry}) {
    state.regionModel = null;
    state.selectedRegion = null;
    regionController.clear();
    cityController.clear();
    districtController.clear();

    state = state.copyWith(
      selectedCountry: selectedCoutry,
      regionModel: state.regionModel,
      selectedRegion: state.selectedRegion,
    );
  }

  selectedRegion({required regionmodel.Datum selectedRegion}) {
    cityController.clear();
    districtController.clear();
    state.selectedRegion = selectedRegion;
    state = state.copyWith(selectedRegion: selectedRegion);
  }

  selectedCity({required citymodel.Datum selectedCity}) {
    districtController.clear();

    state = state.copyWith(selectedCity: selectedCity);
  }

  selectedDistrict({required districtmodel.Datum selectedDistrict}) {
    state = state.copyWith(selectedDistrict: selectedDistrict);
  }

  pickDob({DateTime? dateTime}) {
    if (dateTime != null) {
      String dateOfBirth = DateHelper.formatDate(dateTime.toString());
      dobController.text = dateOfBirth;
    }
  }

  Future<void> registerDeliveryAgents(
      {required Map<String, String> files,
      required Map<String, String> data,
      required WidgetRef ref,
      required BuildContext context}) async {
    try {
      state = state.copyWith(
          deliveryAgentButtonStates: DeliveryAgentButtonLoadingState());
      var headers = {
        'X-API-Key': '79|FOWSWXhxGbJ1WZbGrMsfvA3BgU7wOhomICgYGTy28cdf00a8'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://192.168.1.3:8000/api/delivery_agents/register'));

      request.fields.addAll(data);

      request.headers.addAll(headers);

      for (var entry in files.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(entry.key, entry.value));
      }

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);

        DeliveryAgentModel _deliveryAgentRegistrationModel =
            deliveryAgentModelFromJson(responseBody);

        Utils.showReusableDialog(
            description: _deliveryAgentRegistrationModel.message.toString(),
            context: context,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    ref
                        .read(homeProvider.notifier)
                        .changeIndex(index: 0, ref: ref);

                    context.goNamed(RouteNames.home);

                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            title: 'Operation Successful');
        state = state.copyWith(
            deliveryAgentButtonStates: DeliveryAgentButtonLoadedState(
                deliveryAgentRegistrationModel:
                    _deliveryAgentRegistrationModel));
      } else if (response.statusCode == 400) {
        Map data = jsonDecode(responseBody);

        data.forEach((key, v) {
          for (int i = 0; i < v.length; i++) {
            state = state.copyWith(
                deliveryAgentButtonStates: DeliveryAgentButtonErrorState(
                    errorMessage: v[i].toString()));
          }
        });
      }
    } catch (e, s) {
      print(s);
      state = state.copyWith(
          deliveryAgentButtonStates:
              DeliveryAgentButtonErrorState(errorMessage: 'An Error Occured'));
    }
  }

  Future<void> registerDeliveryAgent(
      {required Map<String, String> files,
      required Map<String, String> data,
      required WidgetRef ref,
      required BuildContext context}) async {
    Either<String, DeliveryAgentModel> apiData = await ref
        .read(getDeliveryAgentApi)
        .registerDeliveryAgent(data: data, files: files);
    apiData.fold((l) {
      log(l.toString());

      if (l.contains('errors')) {
        final data = jsonDecode(l.toString());

        Map<String, dynamic> errors = data['errors'];

        errors.forEach((key, value) {
          (value as List).forEach((v) {
            BotToast.showNotification(
              leading: (cancelFunc) => Icon(
                Icons.info,
                color: ColorManager.whiteColor,
              ),
              backgroundColor: Colors.red,
              title: (title) {
                return Text(
                  v.toString(),
                  style: getRegularStyle(
                      color: ColorManager.whiteColor, fontSize: 14),
                );
              },
            );
          });
        });
      } else {
        BotToast.showNotification(
          leading: (cancelFunc) => Icon(
            Icons.info,
            color: ColorManager.whiteColor,
          ),
          backgroundColor: Colors.red,
          title: (title) {
            return Text(
              l.toString(),
              style:
                  getRegularStyle(color: ColorManager.whiteColor, fontSize: 14),
            );
          },
        );
        // log("Left Side $l");
      }
    }, (r) {
      BotToast.showNotification(
        leading: (cancelFunc) => Icon(
          Icons.info,
          color: ColorManager.whiteColor,
        ),
        backgroundColor: Colors.blue,
        title: (title) {
          return Text(
            r.message.toString(),
            style:
                getRegularStyle(color: ColorManager.whiteColor, fontSize: 14),
          );
        },
      );
      log("Right Side $r");
    });
  }
}
