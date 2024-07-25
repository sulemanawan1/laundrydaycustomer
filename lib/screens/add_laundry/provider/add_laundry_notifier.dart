import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/screens/add_laundry/models/add_laundry_model.dart';
import 'package:laundryday/screens/add_laundry/models/coordinates.dart';
import 'package:laundryday/screens/add_laundry/models/selected_branch_model.dart';
import 'package:laundryday/screens/add_laundry/provider/add_laundry_states.dart';
import 'package:laundryday/screens/add_laundry/service/add_laundry_service.dart';
import 'package:laundryday/screens/services/model/services_model.dart';
import 'package:laundryday/screens/services/service/services_service.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/models/city_model.dart' as citymodel;
import 'package:laundryday/models/country_model.dart' as countrymodel;
import 'package:laundryday/models/district_model.dart' as districtmodel;
import 'package:laundryday/models/region_model.dart' as regionmodel;
import 'package:http/http.dart' as http;


final addLaundryProvider =
    StateNotifierProvider.autoDispose<AddLaundryNotifier, AddLaundryStates>(
        (ref) {
  return AddLaundryNotifier();
});

class AddLaundryNotifier extends StateNotifier<AddLaundryStates> {
  ServiceModel? servicesModel;
  countrymodel.CountryModel? countryModel;
  regionmodel.RegionModel? regionModel;
  citymodel.CityModel? cityModel;
  districtmodel.DistrictModel? districtModel;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  TextEditingController textController = TextEditingController();
  Timer? deounce;
  CameraPosition kGooglePlex =
      const CameraPosition(target: LatLng(0, 0), zoom: 6);

  TextEditingController nameController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController branchesController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController commercialRegoNoController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  AddLaundryNotifier()
      : super(AddLaundryStates(
            selectedBranchModel: [],
            serviceIds: [],
            markers: {
              Marker(
                markerId: MarkerId(const LatLng(0.0, 0.0).toString()),
                position: const LatLng(0.0, 0.0),
                icon: BitmapDescriptor.defaultMarker,
              ),
            },
            currentStep: 0,
            image: null,
            categoryType: null,
            placeList: [])) {
    allServices();
    countries();
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: ImageSource.gallery)
        .then((value) async {
      String? base64Image;

      var fileContent = await value!.readAsBytes();
      base64Image = base64Encode(fileContent);

      state = state.copyWith(image: value, base64Image: base64Image);
    }).onError((error, stackTrace) => Utils.showToast(msg: 'Failed'));
  }

  pickLicenceImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: ImageSource.gallery)
        .then((value) async {
      String? base64Image;

      var fileContent = await value!.readAsBytes();
      base64Image = base64Encode(fileContent);

      state = state.copyWith(
          licenceImage: value, licenseImagebase64Image: base64Image);
    }).onError((error, stackTrace) => Utils.showToast(msg: 'Failed'));
  }

  onStepCancel({required BuildContext context}) {
    if (state.currentStep <= 0) {
      state.currentStep = 0;
      state = state.copyWith(currentStep: state.currentStep);

      context.pop();
    } else {
      state.currentStep = state.currentStep - 1;
      state = state.copyWith(currentStep: state.currentStep);
    }
  }

  onStepContinue({required BuildContext context}) {
    log(state.currentStep.toString());
    state.currentStep++;

    state = state.copyWith(currentStep: state.currentStep);
  }

  onStepFirst() {
    state.currentStep = 1;
    state = state.copyWith(currentStep: state.currentStep);
  }

  setType({required String type}) {
    log(type.toLowerCase());
    state.categoryType = type;
    state = state.copyWith(categoryType: state.categoryType);
  }

  void getSuggestion(String input) async {
    const String placesApiKey = "AIzaSyADOyZQM-g74gad7B-kU4OtuX5cMsJm79M";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$placesApiKey&sessiontoken=1234567890';
      var response = await http.get(Uri.parse(request));

      log(response.body);
      var data = json.decode(response.body);

      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        state.placeList = json.decode(response.body)['predictions'];

        state = state.copyWith(placeList: state.placeList);
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  clearPlaceList() {
    state.placeList.clear();

    state = state.copyWith(placeList: state.placeList);
  }

  assignedAddress({required double lat, required double lng}) {
    state = state.copyWith(selectedLat: lat, selectedLng: lng);
  }

  clearState() {
    state.placeList.clear();
    textController.clear();
    state.googleMapAdress = null;

    state = state.copyWith(
      googleMapAdress: state.googleMapAdress,
      placeList: state.placeList,
    );
  }

  clearList() {
    state.placeList.clear();

    state = state.copyWith(
      placeList: state.placeList,
    );
  }

  Future<Coordinates?> getCoordinates(String address) async {
    final String requestUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyADOyZQM-g74gad7B-kU4OtuX5cMsJm79M';

    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        log(location['lat'].toString());
        log(location['lng'].toString());
        return Coordinates(lat: location['lat'], lng: location['lng']);
      } else {
        print('Error: ${data['status']}');
        return null;
      }
    } else {
      print('Failed to fetch coordinates. Status code: ${response.statusCode}');
      return null;
    }
  }

  setGoogleMapAddress({required String googleMapAddress}) {
    state = state.copyWith(googleMapAdress: googleMapAddress);
    textController.text = state.googleMapAdress!;
  }

  void addMarker({required LatLng position}) {
    if (kDebugMode) {
      print("***********");
      print(position.longitude);
      print(position.latitude);
      print("***********");
    }

    state.markers.clear();
    state.markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        draggable: true,
        onDragEnd: (latLng) {},
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    state = state.copyWith(markers: state.markers);
  }

  void allServices() async {
    var data = await ServicesService.allService();
    if (kDebugMode) {
      print("Data $data");
    }

    if (data is ServiceModel) {
      servicesModel = data;
      state = state.copyWith(
        servicesModel: servicesModel,
      );
    } else {
      state = state.copyWith(
        servicesModel: null,
      );
    }
  }

  void addServiceIds({required List<Datum> values}) async {
    state.serviceIds.clear();
    for (int i = 0; i < values.length; i++) {
      values[i].id;
      state.serviceIds.add(values[i].id!);
    }
    if (kDebugMode) {
      print('Selected Service IDs ${state.serviceIds}');
    }

    state = state.copyWith(serviceIds: state.serviceIds);
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

    if (kDebugMode) {
      print("Data $data");
    }

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

  addBranch(BranchModel branch) {
    state.selectedBranchModel.add(branch);
    countryController.clear();
    textController.clear();
    regionController.clear();
    cityController.clear();
    districtController.clear();
    state.selectedCountry = null;
    state.selectedCity = null;
    state.selectedDistrict = null;
    state.regionModel = null;
    state.googleMapAdress = null;
    state.coordinates = null;
    state.licenceImage = null;
    state.licenseImagebase64Image = null;

    state = state.copyWith(
        image: state.image,
        base64Image: state.base64Image,
        licenceImage: state.licenceImage,
        licenseImagebase64Image: state.licenseImagebase64Image,
        selectedBranchModel: state.selectedBranchModel,
        selectedCountry: state.selectedCountry,
        selectedRegion: state.selectedRegion,
        selectedCity: state.selectedCity,
        selectedDistrict: state.selectedDistrict,
        googleMapAdress: state.googleMapAdress,
        coordinates: state.coordinates);
  }

  deleteBranch(BranchModel branch) {
    state.selectedBranchModel.removeWhere((test) => test == branch);

    state = state.copyWith(selectedBranchModel: state.selectedBranchModel);
  }

  setCoordinates({required Coordinates coodinates}) {
    state = state.copyWith(coordinates: coodinates);
  }

  Future<dynamic> registerLaundry(WidgetRef ref,
      {required Map laundrydata, required BuildContext context}) async {
    var data =
        await AddLaundryService.registerLaundry(laundrydata: laundrydata);

    if (data is AddLaundryModel) {
      if (context.mounted) {
        Utils.showSnackBar(
            context: context,
            message: data.message.toString(),
            color: Colors.green);
        // ref.invalidate(laundriesProvider);
        context.pop();
      }
    } else {
      if (context.mounted) {
        Utils.showSnackBar(
            context: context,
            message: data.toString(),
            color: ColorManager.redColor);
      }
    }
  }
}
