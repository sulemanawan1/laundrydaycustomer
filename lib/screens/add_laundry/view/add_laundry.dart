import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundryday/screens/add_laundry/components/address_information.dart';
import 'package:laundryday/screens/add_laundry/components/business_information_1.dart';
import 'package:laundryday/screens/add_laundry/components/business_information_2.dart';
import 'package:laundryday/screens/add_laundry/components/contact_information.dart';
import 'package:laundryday/screens/add_laundry/models/selected_branch_model.dart';
import 'package:laundryday/screens/add_laundry/provider/add_laundry_notifier.dart';
import 'package:laundryday/screens/add_laundry/provider/add_laundry_states.dart';
import 'package:laundryday/core/constants/colors.dart';
import 'package:laundryday/core/theme/styles_manager.dart';
import 'package:laundryday/core/utils.dart';
import 'package:laundryday/core/widgets/my_app_bar.dart';

final addLaundryProvider =
    StateNotifierProvider.autoDispose<AddLaundryNotifier, AddLaundryStates>(
        (ref) => AddLaundryNotifier());

class AddLaundry extends ConsumerStatefulWidget {
  const AddLaundry({super.key});

  @override
  ConsumerState<AddLaundry> createState() => _LaundriesState();
}

class _LaundriesState extends ConsumerState<AddLaundry> {
  @override
  Widget build(BuildContext context) {
    var states = ref.watch(addLaundryProvider);
    var laundryNotifier = ref.read(addLaundryProvider.notifier);

    return Scaffold(
      appBar: MyAppBar(
        title: 'Register Bussiness',
      ),
      body: Theme(
          data: ThemeData(
            canvasColor: ColorManager.tranparentColor,
          ),
          child: Stepper(
              elevation: 0,
              connectorThickness: 0.3,
              currentStep: states.currentStep,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                              (states) => ColorManager.primaryColor)),
                      onPressed: details.onStepContinue,
                      child: Text(
                        'Continue',
                        style: getMediumStyle(color: ColorManager.whiteColor),
                      ),
                    ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(
                        'Back',
                        style: getMediumStyle(color: ColorManager.blackColor),
                      ),
                    ),
                  ],
                );
              },
              connectorColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorManager.primaryColor;
                }
                return Colors.grey;
              }),
              onStepContinue: () {
                if (states.currentStep == 0 &&
                    businessInformationFormKey.currentState!.validate()) {
                  if (states.categoryType == null) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please Select Laundry Type',
                        color: ColorManager.redColor);
                  } else if (states.serviceIds.isEmpty) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please Select Service',
                        color: ColorManager.redColor);
                  } else {
                    print("*" * 20);
                    print('Step 1');
                    print(laundryNotifier.nameController.text);
                    print(laundryNotifier.arabicNameController.text);
                    print(states.categoryType);
                    print(states.serviceIds);
                    print("*" * 20);

                    ref
                        .read(addLaundryProvider.notifier)
                        .onStepContinue(context: context);
                  }
                } else if (states.currentStep == 1 &&
                    businessInformation2Formkey.currentState!.validate()) {
                  if (states.image == null && states.base64Image == null) {
                    Utils.showSnackBar(
                        context: context,
                        message:
                            'Please  Attach Commercial registration image.',
                        color: ColorManager.redColor);
                  } else {
                    if (kDebugMode) {
                      print("*" * 20);
                      print('Step 2');
                      print(
                          "Brances ${laundryNotifier.branchesController.text}");
                      print(
                          "Tax Number ${laundryNotifier.taxNumberController.text}");
                      print(
                          "Commercial Reg No ${laundryNotifier.commercialRegoNoController.text}");
                      print("Commercial Image ${states.base64Image}");
                      print("*" * 20);
                    }

                    ref
                        .read(addLaundryProvider.notifier)
                        .onStepContinue(context: context);
                  }
                } else if (states.currentStep == 2) {
                  if (laundryNotifier.countryController.text.isEmpty) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please  Select Country',
                        color: ColorManager.redColor);
                  } else if (laundryNotifier.regionController.text.isEmpty) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please  Select Region',
                        color: ColorManager.redColor);
                  } else if (laundryNotifier.cityController.text.isEmpty) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please  Select City',
                        color: ColorManager.redColor);
                  } else if (laundryNotifier.districtController.text.isEmpty) {
                    Utils.showSnackBar(
                        context: context,
                        message: 'Please  Select District',
                        color: ColorManager.redColor);
                  } else if (addressInformationFormKey.currentState!
                      .validate()) {
                    if (kDebugMode) {
                      print("*" * 20);
                      print('Step 3');
                      print("Country ${states.selectedCountry!.id}");
                      print("Region ${states.selectedRegion!.id}");
                      print("City ${states.selectedCity!.id}");
                      print("District ${states.selectedDistrict!.id}");
                      print("Google Map Address ${states.googleMapAdress}");
                      print("Latitiude ${states.coordinates!.lat!}");
                      print("Longitude ${states.coordinates!.lng!}");
                      print("*" * 20);

                      laundryNotifier.addBranch(BranchModel(
                          coordinates: states.coordinates,
                          country: states.selectedCountry,
                          city: states.selectedCity,
                          district: states.selectedDistrict,
                          region: states.selectedRegion,
                          googleMapAddress: states.googleMapAdress));
                    }

                    ref
                        .read(addLaundryProvider.notifier)
                        .onStepContinue(context: context);
                  }
                } else if (contactInformationFormKey.currentState!.validate()) {
                  if (kDebugMode) {
                    print("*" * 20);
                    print('Step 4');
                    print(
                        "First Name ${laundryNotifier.firstNameController.text}");
                    print(
                        "Last Name ${laundryNotifier.lastNameController.text}");
                    print("Email ${laundryNotifier.lastNameController.text}");
                    print(
                        "Password ${laundryNotifier.passwordController.text}");
                    print(
                        "Mobile Number ${laundryNotifier.mobileNumberController.text}");
                    print("Category ${states.categoryType}");

                    List<Map> branch = [];

                    for (int i = 0;
                        i < states.selectedBranchModel.length;
                        i++) {
                      branch.add({
                        "country_id": states.selectedBranchModel[i].country!.id,
                        "region_id": states.selectedBranchModel[i].region!.id,
                        "city_id": states.selectedBranchModel[i].city!.id,
                        "district_id":
                            states.selectedBranchModel[i].district!.id,
                        "postal_code": "",
                        "area": "",
                        "google_map_address":
                            states.selectedBranchModel[i].googleMapAddress,
                        "lat": states.selectedBranchModel[i].coordinates!.lat,
                        "lng": states.selectedBranchModel[i].coordinates!.lng,
                        "address": "123 Main St"
                      });
                    }

                    print(states.base64Image);

                    print("*" * 20);

                    Map data = {
                      "name": laundryNotifier.nameController.text,
                      "arabic_name": laundryNotifier.arabicNameController.text,
                      "type": states.categoryType.toString().toLowerCase(),
                      "branches": int.parse(
                        laundryNotifier.branchesController.text,
                      ),
                      "tax_number": laundryNotifier.taxNumberController.text,
                      "commercial_registration_no":
                          laundryNotifier.commercialRegoNoController.text,
                      "is_central_laundry":
                          states.categoryType == 'laundry' ? 0 : 1,
                      "commercial_registration_image": states.base64Image,
                      "first_name": laundryNotifier.firstNameController.text,
                      "last_name": laundryNotifier.lastNameController.text,
                      "mobile_number":
                          laundryNotifier.mobileNumberController.text,
                      "email": laundryNotifier.emailController.text,
                      "password": laundryNotifier.passwordController.text,
                      "service_ids": states.serviceIds,
                      "branches_list": branch
                    };

                    laundryNotifier.registerLaundry(
                        laundrydata: data, context: context, ref);
                  }
                }
              },
              onStepCancel: () {
                ref
                    .read(addLaundryProvider.notifier)
                    .onStepCancel(context: context);
              },
              type: StepperType.horizontal,
              steps: [
                Step(
                    title: const SizedBox(),
                    isActive: states.currentStep >= 0 ? true : false,
                    content:
                        bussinessInformation(context, laundryNotifier, states)),
                Step(
                    title: const SizedBox(),
                    content: businessInformation2Widget(
                        context, laundryNotifier, states),
                    isActive: states.currentStep >= 1 ? true : false),
                Step(
                    title: const SizedBox(),
                    content:
                        addressInformation(context, laundryNotifier, states),
                    isActive: states.currentStep >= 2 ? true : false),
                Step(
                    title: const SizedBox(),
                    content:
                        contactInformation(context, laundryNotifier, states),
                    isActive: states.currentStep >= 3 ? true : false),
              ])),
    );
  }
}
