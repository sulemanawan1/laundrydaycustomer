import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/helpers/date_helper/date_helper.dart';
import 'package:laundryday/screens/add_laundry/service/add_laundry_service.dart';
import 'package:laundryday/screens/home/provider/home_notifier.dart';
import 'package:laundryday/screens/more/help/agent_registration/model/delivery_agent_registartion_model.dart';
import 'package:laundryday/screens/more/help/agent_registration/provider/delivery_agent_registartion_states.dart';
import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:http/http.dart' as http;
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:laundryday/utils/utils.dart';

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
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(image: value));
  }

  pickIdentityImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(identityImage: value));
  }

  pickRearImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(rearImage: value));
  }

  pickFrontImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(frontImage: value));
  }

  pickdrivingLicenceImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(drivingLicenseImage: value));
  }

  pickRegistrationeImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource)
        .then((value) => state = state.copyWith(registrationImage: value));
  }

  void countries() async {
    var data = await AddLaundryService.countries();

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

  void regions({required int countryId}) async {
    var data = await AddLaundryService.regions(countryId: countryId);

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
    var data = await AddLaundryService.cities(regionId: regionId);
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
    var data = await AddLaundryService.districts(cityId: cityId);

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

  Future<void> registerDeliveryAgent(
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
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://192.168.1.2:8000/api/delivery_agents/register?first_name=Fuzail&last_name=Rajput&delivery_agents_date_of_birth=1998-08-21&delivery_agents_identity_type=National Id&delivery_agents_identity_image='));
      request.fields.addAll(data);

      request.headers.addAll(headers);

      for (var entry in files.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(entry.key, entry.value));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);

        DeliveryAgentRegistrationModel _deliveryAgentRegistrationModel =
            deliveryAgentRegistrationModelFromJson(responseBody);

        Utils.showReusableDialog(
            description: _deliveryAgentRegistrationModel.message.toString(),
            context: context,
            buttons: [
              OutlinedButton(
                  onPressed: () {
                    ref
                        .read(homeProvider.notifier)
                        .changeIndex(index: 0, ref: ref);

                    context.goNamed(RouteNames().home);

                    context.pop();
                  },
                  child: Text('Ok'))
            ],
            title: 'Operation Successful');
        state = state.copyWith(
            deliveryAgentButtonStates: DeliveryAgentButtonLoadedState(
                deliveryAgentRegistrationModel:
                    _deliveryAgentRegistrationModel));
      } else {
        state = state.copyWith(
            deliveryAgentButtonStates:
                DeliveryAgentButtonErrorState(errorMessage: 'Server Error'));
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
          deliveryAgentButtonStates: DeliveryAgentButtonErrorState(
              errorMessage: 'Something Went Wrong'));
    }
  }
}
