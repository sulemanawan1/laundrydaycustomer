import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundryday/app_services/image_picker_handler.dart';
import 'package:laundryday/models/city.dart';
import 'package:laundryday/models/services_model.dart';
import 'package:laundryday/models/state.dart';
import 'package:laundryday/screens/more/help/business_partner/models/bussiness_partner_model.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_state.dart';
import 'package:laundryday/screens/more/help/business_partner/notifier/business_partner_textformfields.dart';
import 'package:laundryday/utils/routes/route_names.dart';
import 'package:http/http.dart' as http;
import 'package:laundryday/utils/utils.dart';

final businessPartnerProvider = StateNotifierProvider.autoDispose<
    BusinessPartnerNotifier, BusinessPartnerState>((ref) {
  return BusinessPartnerNotifier();
});

class BusinessPartnerNotifier extends StateNotifier<BusinessPartnerState> {
  BusinessPartnerNotifier()
      : super(BusinessPartnerState(
            regionId: 0,
            type: '',
            currentStep: 0,
            laundriesList: [],
            items: [
              ServicesModel(
                  vat: 0.00,
                  id: 1,
                  name: 'Clothes',
                  deliveryFee: 14.00,
                  operationFee: 2.00,
                  image: 'assets/services_clothing.jpg',
                  images: []),
              ServicesModel(
                  vat: 0.00,
                  id: 2,
                  deliveryFee: 18.00,
                  operationFee: 2.00,
                  name: 'Blankets',
                  image: 'assets/services_blankets.jpg',
                  images: []),
              ServicesModel(
                  vat: 0.00,
                  id: 3,
                  deliveryFee: 11.50,
                  operationFee: 2.00,
                  name: "Carpets",
                  image: 'assets/services_carpets.jpeg',
                  images: []),
              ServicesModel(
                  vat: 0.0,
                  id: 4,
                  deliveryFee: 14.00,
                  operationFee: 2.00,
                  name: "Furniture",
                  image: 'assets/services_furniture.jpeg',
                  images: [])
            ],
            selectedItems: [],
            image: null,
            categoryType: null)) {}

  addItem(ServicesModel item) {
    state.selectedItems.add(item);
    state.selectedItems = [...state.selectedItems];
  }

  removeItem(String item) {
    log(item);

    state.selectedItems.remove(item);
    state.selectedItems = [...state.selectedItems];
  }

  pickImage({required ImageSource imageSource}) {
    ImagePickerHandler.pickImage(imageSource: imageSource).then((value) {
      return state = state.copyWith(image: value);
    });
  }

  addBusiness({required LaundryBusinessModel laundryBusinessModel}) {
    log(laundryBusinessModel.toString());

    state.laundriesList.add(laundryBusinessModel);

    state = state.copyWith(laundriesList: state.laundriesList);
  }

  deleteBusiness({required String id}) {
    state.laundriesList.removeWhere((element) => element.id == id);

    state = state.copyWith(laundriesList: state.laundriesList);
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

    if (state.currentStep == 3) {
      if (BusinessPartnerTextFormFields.formKey4.currentState!.validate()) {
        Fluttertoast.showToast(msg: 'You are under Verification.');

        context.pushReplacementNamed(RouteNames().services);
        BusinessPartnerTextFormFields.cleartAllTextFormFields();
      }
    } else if (state.currentStep < 3) {
      if (state.currentStep == 0 &&
          BusinessPartnerTextFormFields.formKey1.currentState!.validate()) {
        state.currentStep = state.currentStep + 1;
        state = state.copyWith(currentStep: state.currentStep);
      } else if (state.currentStep == 1 &&
          BusinessPartnerTextFormFields.formKey2.currentState!.validate()) {
        state.currentStep = state.currentStep + 1;
        state = state.copyWith(currentStep: state.currentStep);
      } else if (state.currentStep == 2 &&
          BusinessPartnerTextFormFields.formKey3.currentState!.validate()) {
        state.currentStep = state.currentStep + 1;
        state = state.copyWith(currentStep: state.currentStep);
      }
    }
  }

  onStepFirst() {
    state.currentStep = 0;
    state = state.copyWith(currentStep: state.currentStep);
  }

  Future<Regions?> fetchRegions() async {
    try {
      final response =
          await http.post(Uri.parse('http://192.168.1.4:8000/api/states/194'));
      if (response.statusCode == 200) {
        final li = Regions.fromJson(response.body);

        return Regions.fromJson(response.body);
      } else {
        throw Exception('Failed to load Region');
      }
    } on SocketException catch (e) {
      Utils.showToast(msg: e);
    }

    return null;
  }

  Future<Cities?> fetchCities({required int regionId}) async {
    log(regionId.toString());
    try {
      final response = await http
          .post(Uri.parse('http://192.168.1.4:8000/api/cities/$regionId'));
      if (response.statusCode == 200) {
        log('ok');
        return Cities.fromJson(response.body);
      } else {
        throw Exception('Failed to load Region');
      }
    } on SocketException catch (e) {
      Utils.showToast(msg: e);
    }

    return null;
  }

  setRegionId({required int regionId}) {
    state = state.copyWith(regionId: regionId);
  }


   setType({required String type}) {
    state = state.copyWith(type: type);
  }
}
